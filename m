Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132526AbREFKKD>; Sun, 6 May 2001 06:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135325AbREFKJx>; Sun, 6 May 2001 06:09:53 -0400
Received: from spiral.extreme.ro ([212.93.159.205]:7305 "HELO
	spiral.extreme.ro") by vger.kernel.org with SMTP id <S132526AbREFKJu>;
	Sun, 6 May 2001 06:09:50 -0400
Date: Sun, 6 May 2001 13:10:01 +0300 (EEST)
From: Dan Podeanu <pdan@spiral.extreme.ro>
To: =?iso-8859-1?Q?Christian_Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: DISCOVERED! Cause of Athlon/VIA KX133 Instability
In-Reply-To: <001201c0d60c$a5a3c920$3303a8c0@pnetz>
Message-ID: <Pine.LNX.4.30.0105061308410.27147-100000@spiral.extreme.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No matter if I use the mandrake 8 gcc 2.96 or a self compiled gcc 2.95.3.

Mandrake 8's kernel comes with i586 CPU support, it is alredy known it
works. Remember that the instability occurs only when Athlon optimizations
are used.

