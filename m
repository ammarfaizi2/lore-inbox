Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136127AbRDVNvg>; Sun, 22 Apr 2001 09:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136125AbRDVNv0>; Sun, 22 Apr 2001 09:51:26 -0400
Received: from pc57-cam4.cable.ntl.com ([62.253.135.57]:56707 "EHLO
	kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S136119AbRDVNvT>; Sun, 22 Apr 2001 09:51:19 -0400
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: junio@siamese.dhis.twinsun.com, manuel@mclure.org (Manuel McLure),
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac12 
In-Reply-To: Message from Alan Cox <alan@lxorguk.ukuu.org.uk> 
   of "Sun, 22 Apr 2001 14:10:41 BST." <E14rJdU-0005p0-00@the-village.bc.nu> 
In-Reply-To: <E14rJdU-0005p0-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 22 Apr 2001 14:51:03 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E14rKGW-0005qT-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>There are no gcc 2.97 snapshots that compile the kernel correctly because
>they have the broken bitfield packing ABI change. 

Oh right.  I didn't know about that particular nicety.

>My belief however is that several million people have gcc 2.96-69+, about 50
>are likely to have random cvs snapshots and none of them are going to build
>kernels with them anyway, as they wont work __builtin_expect or otherwise.

Fair enough.

p.



