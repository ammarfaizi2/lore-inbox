Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265376AbRFWBD2>; Fri, 22 Jun 2001 21:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265392AbRFWBDS>; Fri, 22 Jun 2001 21:03:18 -0400
Received: from pop.gmx.net ([194.221.183.20]:15241 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265376AbRFWBDM>;
	Fri, 22 Jun 2001 21:03:12 -0400
Message-ID: <3B33E498.7099DF1B@gmx.de>
Date: Sat, 23 Jun 2001 02:36:40 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Thomas Speck <Thomas.Speck@univ-rennes1.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: problem with select() - 2.4.5
In-Reply-To: <Pine.LNX.4.21.0106222150090.12493-100000@pc-astro.spm.univ-rennes1.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Speck wrote:
> 
>         tio.c_cflag = baud | CLOCAL;

How about adding CREAD?

Ciao, ET.

