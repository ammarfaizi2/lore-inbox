Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262823AbSJJCi5>; Wed, 9 Oct 2002 22:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262828AbSJJCi5>; Wed, 9 Oct 2002 22:38:57 -0400
Received: from mnh-1-27.mv.com ([207.22.10.59]:18949 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S262823AbSJJCi5>;
	Wed, 9 Oct 2002 22:38:57 -0400
Message-Id: <200210100348.WAA05793@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: user-mode-linux-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>
Subject: Re: [PATCH] export __do_copy_to_user 
In-Reply-To: Your message of "Tue, 08 Oct 2002 15:07:18 +0400."
             <15778.48230.397957.681553@laputa.namesys.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 09 Oct 2002 22:48:47 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita@Namesys.COM said:
> this patch exports __do_copy_to_user() in arch/um/kernel/ksyms.c. This
> is necessary to build any file-system as module in the UML. 

Applied, thanks.

		Jeff

