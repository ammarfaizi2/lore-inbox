Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314486AbSE0IZj>; Mon, 27 May 2002 04:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314505AbSE0IZi>; Mon, 27 May 2002 04:25:38 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:1294 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S314486AbSE0IZi>; Mon, 27 May 2002 04:25:38 -0400
Message-ID: <3CF1ED6D.1030202@loewe-komp.de>
Date: Mon, 27 May 2002 10:25:17 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Aaron Sethman <androsyn@ratbox.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: RT Sigio broken on 2.4.19-pre8
In-Reply-To: <Pine.LNX.4.44.0205250433050.9132-100000@simon.ratbox.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Sethman wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> Using the Dan Kegel's Poller_bench utility I noticed that RT SIGIO is not
> working on 2.4.19-pre8.  Basically sigtimedwait() is always returning
> SIGIO.  Note that 2.4.18 works fine.
> 

What is this Poller_bench and where do I get it?


