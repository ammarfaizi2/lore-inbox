Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVCOMX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVCOMX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 07:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVCOMX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 07:23:28 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:18700 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261195AbVCOMVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 07:21:54 -0500
Message-ID: <4236D428.4080403@aitel.hist.no>
Date: Tue, 15 Mar 2005 13:25:12 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm3 mouse oddity
References: <20050312034222.12a264c4.akpm@osdl.org>
In-Reply-To: <20050312034222.12a264c4.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.11-mm1 and earlier: mouse appear as /dev/input/mouse0
2.6.11-mm3: mouse appear as /dev/input/mouse1

No big problem, one change to xorg.conf and I got the mouse back.
I guess it wasn't supposed to change like that though?

This is a mouse connected to the ps2 port, also appearing as /dev/psaux

Helge Hafting
