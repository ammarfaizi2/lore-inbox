Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbTFKPg6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 11:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbTFKPg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 11:36:58 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:41483 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S262413AbTFKPg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 11:36:57 -0400
Message-ID: <3EE75144.4030300@kolumbus.fi>
Date: Wed, 11 Jun 2003 18:56:52 +0300
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2][2.5]Unisys ES7000 platform subarch
References: <3FAD1088D4556046AEC48D80B47B478C022BDA75@usslc-exch-4.slc.unisys.com>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 11.06.2003 18:51:56,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 11.06.2003 18:51:23,
	Serialize complete at 11.06.2003 18:51:23
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just out of curiosity, what are "Physical Cluster" and "Logical 
Cluster"?  This terminology doesn't appear in Intel documentation. 
AFAIK, IPIs are currently always sent using logical destination mode, 
and in your patch ioapic entries have logical mode in cluster case. So 
where does physical cluster  come into play?

--Mika


