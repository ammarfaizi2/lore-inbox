Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317388AbSFMBLx>; Wed, 12 Jun 2002 21:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317390AbSFMBLw>; Wed, 12 Jun 2002 21:11:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18647 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317388AbSFMBLw>;
	Wed, 12 Jun 2002 21:11:52 -0400
Date: Wed, 12 Jun 2002 18:07:25 -0700 (PDT)
Message-Id: <20020612.180725.18975907.davem@redhat.com>
To: roland@topspin.com
Cc: marcelo@conectiva.com.br, david-b@pacbell.net, oliver@neukum.name,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4 add __dma_buffer alignment macro
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <52wut42fig.fsf_-_@topspin.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just use asm/dma.h, no need to make a new file.
