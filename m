Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286936AbRL1R2u>; Fri, 28 Dec 2001 12:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284138AbRL1R2l>; Fri, 28 Dec 2001 12:28:41 -0500
Received: from 247.229.252.64.snet.net ([64.252.229.247]:14721 "EHLO
	karaya.com") by vger.kernel.org with ESMTP id <S286937AbRL1R2d>;
	Fri, 28 Dec 2001 12:28:33 -0500
Message-Id: <200112281831.fBSIVJq03612@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: andersg@0x63.nu
cc: linux-kernel@vger.kernel.org
Subject: Re: UML has been sent to Linus 
In-Reply-To: Your message of "Fri, 28 Dec 2001 11:16:47 +0100."
             <20011228101647.GB20899@h55p111.delphi.afb.lu.se> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Dec 2001 13:31:18 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andersg@0x63.nu said:
> is it available somewhere? 

http://prdownloads.sourceforge.net/user-mode-linux/uml-patch-2.5.1-1.bz2

plus it's mirrored in various places - start with 
	http://user-mode-linux.sourceforge.net/dl-sf.html

It's the same UML as the 2.4.17 I released last night with some changes
in the block driver required by the bio changes.

				Jeff

