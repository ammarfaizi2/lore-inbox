Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267478AbTACJT5>; Fri, 3 Jan 2003 04:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267480AbTACJT4>; Fri, 3 Jan 2003 04:19:56 -0500
Received: from tag.witbe.net ([81.88.96.48]:41231 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S267478AbTACJTz>;
	Fri, 3 Jan 2003 04:19:55 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Aniruddha M Marathe'" <aniruddha.marathe@wipro.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.54] OOPS: unable to handle kernel paging request
Date: Fri, 3 Jan 2003 10:28:13 +0100
Message-ID: <007201c2b30a$708a6c80$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <94F20261551DC141B6B559DC49108672044910@blr-m3-msg.wipro.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nope, it was really configure as P4, and I really have a P4.

Paul

> -----Original Message-----
> From: Aniruddha M Marathe [mailto:aniruddha.marathe@wipro.com] 
> Sent: Friday, January 03, 2003 9:33 AM
> To: Paul Rolland
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: [2.5.54] OOPS: unable to handle kernel paging request
> 
> 
> >
> Check if the processor in your .config matches with the 
> processor that you have. Eg. Problme might arise if .config 
> file says CONFIG_MPENTIUMIII=y when your processor is P4.
> 

