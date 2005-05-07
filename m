Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVEGQfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVEGQfp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 12:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVEGQfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 12:35:45 -0400
Received: from mail.nagafix.co.uk ([213.228.237.37]:7301 "EHLO
	mail.nagafix.co.uk") by vger.kernel.org with ESMTP id S261439AbVEGQfl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 12:35:41 -0400
Subject: Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
From: Antoine Martin <antoine@nagafix.co.uk>
To: Alexander Nyberg <alexn@telia.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1115481468.925.9.camel@localhost.localdomain>
References: <20050504191828.620C812EE7@sc8-sf-spam2.sourceforge.net>
	 <1115248927.12088.52.camel@cobra>  <1115392141.12197.3.camel@cobra>
	 <1115483506.12131.33.camel@cobra>
	 <1115481468.925.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 07 May 2005 19:06:44 +0100
Message-Id: <1115489204.12424.4.camel@cobra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3-1.3.101mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I never get uml to compile around here, 2.6.12-rc3 + that patchkit from
> the link you sent blows up with defconfig any my minimal config. Please
> attach your guest .config and if you can you might aswell put your guest
> vmlinux somewhere where i can download it too.
ok, here it is:
http://213.228.237.37/uml/2.6.12-rc3/
kernel and config.

Note: you will need a pure 64bit root fs, ie: gentoo 2005 works fine.

