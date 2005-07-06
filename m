Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbVGFVmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVGFVmz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 17:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbVGFVjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 17:39:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3795 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262530AbVGFVjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 17:39:24 -0400
Date: Wed, 6 Jul 2005 14:39:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Mahoney <jeffm@suse.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       benh@kernel.crashing.org
Subject: Re: [PATCH 2/3 (updated)] openfirmware: add sysfs nodes for open
 firmware devices
In-Reply-To: <Pine.LNX.4.58.0507061346440.4159@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0507061438080.3847@g5.osdl.org>
References: <20050706192627.GA17492@locomotive.unixthugs.org>
 <Pine.LNX.4.58.0507061241010.3570@g5.osdl.org> <Pine.LNX.4.58.0507061317250.4114@g5.osdl.org>
 <42CC4177.9020607@suse.com> <Pine.LNX.4.58.0507061346440.4159@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Jul 2005, Linus Torvalds wrote:
> 
> However, I don't think it was your patches after all.  I'm still hunting, 
> but it might even have been a totally unrelated "yum upgrade". 

Confirmed. Sorry for the noise. The upgrade had apparently decided to 
replace my xorg.conf with a "failsafe" one.

Patches applied and pushed out.

		Linus
