Return-Path: <linux-kernel-owner+w=401wt.eu-S932704AbWLZQY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbWLZQY0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 11:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbWLZQYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 11:24:25 -0500
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:54294 "EHLO
	mtiwmhc13.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932669AbWLZQYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 11:24:25 -0500
Message-ID: <45914CAF.1070907@lwfinger.net>
Date: Tue, 26 Dec 2006 10:24:15 -0600
From: Larry Finger <larry.finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: bert hubert <bert.hubert@netherlabs.nl>,
       Larry Finger <Larry.Finger@lwfinger.net>,
       Broadcom Linux <bcm43xx-dev@lists.berlios.de>,
       netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: bcm43xx-softmac broken on 2.6.20-rc2
References: <458EA216.7000101@lwfinger.net> <20061226154524.GB12583@outpost.ds9a.nl>
In-Reply-To: <20061226154524.GB12583@outpost.ds9a.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:
> On Sun, Dec 24, 2006 at 09:51:50AM -0600, Larry Finger wrote:
>> This is a heads-up for anyone wishing to use bcm43xx-softmac on Linus's git 
>> tree, which is now at
>> v2.6.20-rc2. There are two serious bugs in that code. Fixes are found below.
> 
> For some reason your patch does not apply to stock 2.6.20-rc2, although I
> don't see why. Applying it by hand makes things compile though, and even
> fixes the problem I mentioned in my previous post:

The patch does not apply because your mailer is breaking the white space and substituting spaces for 
tabs.

Larry
