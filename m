Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132228AbRCVXCt>; Thu, 22 Mar 2001 18:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132231AbRCVXCb>; Thu, 22 Mar 2001 18:02:31 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25866 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132228AbRCVXCP>; Thu, 22 Mar 2001 18:02:15 -0500
Subject: Re: supermount ?
To: gerry@c64.org (Gerry)
Date: Thu, 22 Mar 2001 23:03:55 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01032223210703.00829@localhost.localdomain> from "Gerry" at Mar 22, 2001 11:21:07 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gE7b-0003VP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Supermount sounds to me like a very important part of linux, at least for us 
> who like our cds/dvds/etc. to work as easily as in fx. windows. For linux to 
> be popular among "normal" users, it should be present at every system with 
> local removable drives. So, my question is; why isn't supermount a standard 
> part of the kernel, or at least a module ?

Because it wants rewriting as a clean file system using the 2.4 dcache and
layering itself above the real fs. In theory the infrastructure for this is
all there. 

Alan

