Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264773AbRFSUg1>; Tue, 19 Jun 2001 16:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264774AbRFSUgK>; Tue, 19 Jun 2001 16:36:10 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24594 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264773AbRFSUfr>; Tue, 19 Jun 2001 16:35:47 -0400
Subject: Re: How to compile on one machine and install on another?
To: john.mcharry@gemplex.com (McHarry, John)
Date: Tue, 19 Jun 2001 21:35:06 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A5F553757C933442ADE9B31AF50A273B028DB4@corp-p1.gemplex.com> from "McHarry, John" at Jun 19, 2001 04:32:03 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15CSDK-0006ee-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am trying to compile the 2.2.19 kernel one one machine for  installation
> on another.  I believe I need to do more than just copy over  bzImage and
> modify lilo.conf, but I don't know what.  Is there documentation somewhere
> on how to do this?  Thanks.

Other than making sure you configure it for the box it will eventually run
on - nope you have it all sorted. If you use modules you'll want to install
the modules on the target machine too
