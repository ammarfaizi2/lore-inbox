Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbSKOBbO>; Thu, 14 Nov 2002 20:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265517AbSKOBbO>; Thu, 14 Nov 2002 20:31:14 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:19885 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265477AbSKOBbN>; Thu, 14 Nov 2002 20:31:13 -0500
Subject: Re: PROBLEM: Driver nm256_audio in a nm256 without ac97 mixer [1.]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Maxi Pedraza Padilla <maximpedraza@laporxada.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DD443D3.7090104@laporxada.net>
References: <3DD443D3.7090104@laporxada.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Nov 2002 02:04:15 +0000
Message-Id: <1037325855.17733.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-15 at 00:46, Maxi Pedraza Padilla wrote:
> [2.] This modules don't work with my sound card, that is an nm256av in a 
> Compaq Presario 1920. I try force_ac97, then load the modules, but the 
> sound don't work or hang on my system.
> 
> [3.] Sound
> [4.] 2.4.20 but the modules is the same  2.2, 2.4 and 2.5...

There are three ways the nm256 can be set up - you might also need to
use the ad1848 or sound blaster driver depending on your machine


