Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316604AbSFDMpg>; Tue, 4 Jun 2002 08:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316609AbSFDMpf>; Tue, 4 Jun 2002 08:45:35 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:3319 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316604AbSFDMpf>; Tue, 4 Jun 2002 08:45:35 -0400
Subject: Re: [PATCH] 2.2.21 s/Efoo/-Efoo/ drivers/char/rio/*.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Anthony J.  " Breeds-Taurima <tony@cantech.net.au>
Cc: lkml <linux-kernel@vger.kernel.org>, Rogier Wolff <R.E.Wolff@BitWizard.nl>
In-Reply-To: <Pine.LNX.4.44.0206041649020.32156-100000@thor.cantech.net.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Jun 2002 14:50:52 +0100
Message-Id: <1023198652.23878.133.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-04 at 09:51, Anthony J. Breeds-Taurima wrote:
> Hello All,
> 	Backport of changes in 2.5 and (hopefully) in 2.4 to 2.2.
> Intent is to keep code base as similar as possible.

Rejected. The goal for 2.2 is to make only essential changes now.

