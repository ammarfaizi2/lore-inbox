Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281262AbRKPJwL>; Fri, 16 Nov 2001 04:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281263AbRKPJwC>; Fri, 16 Nov 2001 04:52:02 -0500
Received: from corp.tivoli.com ([216.140.178.60]:13033 "EHLO corp.tivoli.com")
	by vger.kernel.org with ESMTP id <S281262AbRKPJvs>;
	Fri, 16 Nov 2001 04:51:48 -0500
Message-ID: <3BF44BD0.1020002@tiscalinet.it>
Date: Thu, 15 Nov 2001 18:12:16 -0500
From: "D'Angelo Salvatore" <dangelo.sasaman@tiscalinet.it>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IBM Token Ring
X-MIMETrack: Itemize by SMTP Server on RomeMTA/Tivoli Systems(Release 5.0.8 |June 18, 2001) at
 11/15/2001 06:12:25 PM,
	Serialize by Router on RomeMTA/Tivoli Systems(Release 5.0.8 |June 18, 2001) at
 11/16/2001 10:51:47 AM,
	Serialize complete at 11/16/2001 10:51:47 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a Thinkpad 600X with IBM 16/4 Token-Ring Card Bus adapter and I 
compiled the kernel 2.4.14 (Mandrake 7.2) BM using the configuration 
file attached to this mail.

The module used is ibmtr_cs.

The problem occur when I try to bring up the tr0 interface and the 
following message appear:

               delaying tr0 initialization [FAILED]

Using the command

               ifconfig tr0 up

this other message appear

               tr0: unknown interface: no such device

any suggestion are welcomed.

PS

please cc also to to camoroso@tivoli.com <mailto:camoroso@tivoli.com>


