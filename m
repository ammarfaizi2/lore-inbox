Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319021AbSHMN4a>; Tue, 13 Aug 2002 09:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319020AbSHMN4a>; Tue, 13 Aug 2002 09:56:30 -0400
Received: from d109-ps5-mel.alphalink.com.au ([202.161.111.237]:8064 "HELO
	spunk.spunk") by vger.kernel.org with SMTP id <S319022AbSHMN43>;
	Tue, 13 Aug 2002 09:56:29 -0400
Date: Wed, 14 Aug 2002 00:09:22 +1000
From: ecoffey@alphalink.com.au
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.31
Message-ID: <20020813140922.GA658@spunk>
References: <Pine.LNX.4.33.0208101854340.2656-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0208101854340.2656-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

devfs problem, make modules_install fails with:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.31; fi
depmod: *** Unresolved symbols in
/lib/modules/2.5.31/kernel/sound/core/snd.o
depmod:         devfs_find_and_unregister

Ed.
