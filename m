Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314513AbSEHRGS>; Wed, 8 May 2002 13:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314681AbSEHRGR>; Wed, 8 May 2002 13:06:17 -0400
Received: from [203.197.145.76] ([203.197.145.76]:62219 "EHLO
	mailnpd.hcltech.com") by vger.kernel.org with ESMTP
	id <S314513AbSEHRGQ>; Wed, 8 May 2002 13:06:16 -0400
Message-ID: <3CD959E4.A2B93D37@npd.hcltech.com>
Date: Wed, 08 May 2002 22:31:24 +0530
From: Kaushik Datta <kdatta@npd.hcltech.com>
Organization: HCL technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Abort handler !
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ,

   I have a pseudo HBA LLD with the assicoated functions as in the
   SCSI HOST Template .Now we have a situation when the abort
   handler of the LLD is getting (eh_abort_handler) called early than
   we would desire it to be called !! Is there any way by which I can
   increase the delay after which the abort handler of our pseudo
   HBA LLD will be called by the mid level ??

   Thanks,
    Kaushik

