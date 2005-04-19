Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVDSWTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVDSWTZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 18:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVDSWTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 18:19:25 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:4044 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261697AbVDSWTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 18:19:09 -0400
Message-ID: <426583D5.2020308@mesatop.com>
Date: Tue, 19 Apr 2005 16:19:01 -0600
From: Steven Cole <elenstev@mesatop.com>
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Greg KH <greg@kroah.com>, Greg KH <gregkh@suse.de>,
       Git Mailing List <git@vger.kernel.org>, linux-kernel@vger.kernel.org,
       sensors@stimpy.netroedge.com
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com> <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 19 Apr 2005, Greg KH wrote:
> 
>>Nice, it looks like the merge of this tree, and my usb tree worked just
>>fine.
> 
> 
> Yup, it all seems to work out.

[many files patched]
patching file mm/mmap.c
patching file net/bridge/br_sysfs_if.c
patching file scripts/ver_linux
----------------------^^^^^^^^^
Hey, that's my patch!  Last...and least.
But perhaps a progress bar right about here might be
a good thing for the terminally impatient.

real    3m54.909s
user    0m14.835s
sys     0m10.587s

4 minutes might be long enough to cause some folks to lose hope.

Steven

