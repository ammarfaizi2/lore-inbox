Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317269AbSIIM2h>; Mon, 9 Sep 2002 08:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317282AbSIIM2g>; Mon, 9 Sep 2002 08:28:36 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:35574
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317269AbSIIM2g>; Mon, 9 Sep 2002 08:28:36 -0400
Subject: Re: question about machne checksum errors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Atish Datta Chowdhury <adattachowdhury@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020909122604.10354.qmail@web20803.mail.yahoo.com>
References: <20020909122604.10354.qmail@web20803.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 09 Sep 2002 13:35:59 +0100
Message-Id: <1031574959.29793.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-09 at 13:26, Atish Datta Chowdhury wrote:
>               The servers that we get these occasional
> errors on, are mostly dual AMD boxes (MP 1800s, 
> typically) running 2.4.18.  Are the decoding rules, 
> present in Intel's IA-32 MCA documentation, applicable

No idea. I've not seen an AMD document specifying how they encode their
error reports. Normally its overheating and/or crappy power supplies.
The dual Athlons burn power and output huge amounts of heat.


