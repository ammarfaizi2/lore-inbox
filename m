Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVDFMCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVDFMCe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 08:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbVDFMCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 08:02:31 -0400
Received: from host217-40-213-68.in-addr.btopenworld.com ([217.40.213.68]:5337
	"EHLO SERRANO.CAM.ARTIMI.COM") by vger.kernel.org with ESMTP
	id S262178AbVDFLxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 07:53:08 -0400
From: "Dave Korn" <dave.korn@artimi.com>
To: "'Dave Korn'" <dave.korn@artimi.com>,
       "'Denis Vlasenko'" <vda@port.imtp.ilyichevsk.odessa.ua>,
       "'Christophe Saout'" <christophe@saout.de>
Cc: "'Andrew Morton'" <akpm@osdl.org>, "'Jan Hubicka'" <hubicka@ucw.cz>,
       "'Gerold Jury'" <gerold.ml@inode.at>, <jakub@redhat.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       <gcc@gcc.gnu.org>
Subject: RE: [BUG mm] "fixed" i386 memcpy inlining buggy
Date: Wed, 6 Apr 2005 12:53:01 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <SERRANOMjkatwD43oFL0000007a@SERRANO.CAM.ARTIMI.COM>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcU6mMx7UselsSWPRcmlLlhiWHQ0KAAAMLGQAAFhoWA=
Message-ID: <SERRANOEKRuYDlrjbud0000007e@SERRANO.CAM.ARTIMI.COM>
X-OriginalArrivalTime: 06 Apr 2005 11:53:04.0502 (UTC) FILETIME=[30EDA960:01C53A9F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Original Message----
>From: Dave Korn
>Sent: 06 April 2005 12:13

> ----Original Message----
>> From: Dave Korn
>> Sent: 06 April 2005 12:06
> 
> 
>   Me and my big mouth.
> 
>   OK, that one does work.
> 
>   Sorry for the outburst.
> 


.... well, actually, maybe it doesn't after all.


  What's that uninitialised variable ecx doing there eh?


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....

