Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261345AbSJHQNT>; Tue, 8 Oct 2002 12:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261347AbSJHQNT>; Tue, 8 Oct 2002 12:13:19 -0400
Received: from host194.steeleye.com ([66.206.164.34]:58120 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S261345AbSJHQNS>; Tue, 8 Oct 2002 12:13:18 -0400
Message-Id: <200210081618.g98GIwo02176@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Adrian Bunk <bunk@fs.tum.de>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       James Bottomley <James.Bottomley@HansenPartnership.com>,
       Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.41-ac1 
In-Reply-To: Message from Adrian Bunk <bunk@fs.tum.de> 
   of "Tue, 08 Oct 2002 18:08:53 +0200." <Pine.NEB.4.44.0210081804260.8340-100000@mimas.fachschaften.tu-muenchen.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Oct 2002 12:18:57 -0400
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps a better option is to add a single config option that compiles the 
trampoline (CONFIG_X86_TRAMPOLINE) then I can build the object for both 
voyager and smp x86.

James


