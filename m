Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752354AbWCFJbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbWCFJbm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 04:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752355AbWCFJbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 04:31:42 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:8848 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1752351AbWCFJbm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 04:31:42 -0500
Message-ID: <440C0175.7040909@aitel.hist.no>
Date: Mon, 06 Mar 2006 10:31:33 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jonathan@jonmasters.org
CC: Chris Ball <cjb@mrao.cam.ac.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OT] inotify hack for locate
References: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com>	 <yd3bqwkbgsi.fsf@islay.ra.phy.cam.ac.uk> <35fb2e590603051704k120e0257wb39c3e3eb1cf0b49@mail.gmail.com>
In-Reply-To: <35fb2e590603051704k120e0257wb39c3e3eb1cf0b49@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Masters wrote:

>You're right. What I want really is to be able to bind to a netlink
>socket and get told about particular file IO operations I'm interested
>in for the /whole/ of a filesystem. The same kind of thing that real
>time anti-virus/anti-spam people want to do anyway.
>
>  
>
Do they?
I thought all this mail processing could be done in the mailserver
and/or mail reader.  Why detect spam by looking for generic file
creation when you can trivially tap into mail as it arrives?

As for the non-existent virus problem - it is mostly prevented
by users not being administrators.  And you can go further
with a readonly /usr and a noexec /home.

Helge Hafting
