Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbSLIPIV>; Mon, 9 Dec 2002 10:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265612AbSLIPIV>; Mon, 9 Dec 2002 10:08:21 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:31932 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265603AbSLIPIU>; Mon, 9 Dec 2002 10:08:20 -0500
Subject: Re: IDE feature request
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: hps@intermeta.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <at28st$ifd$1@forge.intermeta.de>
References: <068d01c29d97$f8b92160$551b71c3@krlis>
	<1039312135.27904.11.camel@irongate.swansea.linux.org.uk>
	<20021208234102.GA8293@scssoft.com>  <at28st$ifd$1@forge.intermeta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Dec 2002 15:52:35 +0000
Message-Id: <1039449155.10470.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-09 at 14:21, Henning P. Schmiedehausen wrote:
> you will get the same problem again, once someone is able to cram more than
> 16 IDE hosts into a box. Why not go for ide%d (ide0-9, ide10-99)?
> 
> If we go to idea - idef now, we will be stuck with that for ages.

Minimal change for 2.4 - you run out of minors anyway 8)

