Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbUAOVX0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 16:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUAOVX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 16:23:26 -0500
Received: from mail.gmx.de ([213.165.64.20]:11925 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263618AbUAOVXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 16:23:22 -0500
X-Authenticated: #4512188
Message-ID: <400704C5.2080309@gmx.de>
Date: Thu, 15 Jan 2004 22:23:17 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] add sysfs class support for OSS sound devices [07/10]
References: <20040115204048.GA22199@kroah.com> <20040115204111.GB22199@kroah.com> <20040115204125.GC22199@kroah.com> <20040115204138.GD22199@kroah.com> <20040115204153.GE22199@kroah.com> <20040115204209.GF22199@kroah.com> <20040115204241.GG22199@kroah.com> <20040115204259.GH22199@kroah.com>
In-Reply-To: <20040115204259.GH22199@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> This patch adds support for all OSS sound devices.

Please excuse my ignorance, but shouldn't these patches be sent to alsa? 
I mean unless they are in their cvs, updateing alsa drivers will become 
a hard task.

Prakash
