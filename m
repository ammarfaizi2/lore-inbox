Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbRB0MnS>; Tue, 27 Feb 2001 07:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129126AbRB0MnI>; Tue, 27 Feb 2001 07:43:08 -0500
Received: from granch.com ([212.109.197.246]:55058 "EHLO granch.com")
	by vger.kernel.org with ESMTP id <S129115AbRB0Mms>;
	Tue, 27 Feb 2001 07:42:48 -0500
Date: Tue, 27 Feb 2001 18:42:01 +0600 (NOVT)
From: "Yaroslav S. Polyakov" <xenon@granch.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Yaroslav Polyakov <xenon@granch.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sbni: update last_rx after netif_rx
In-Reply-To: <20010226224911.C8692@conectiva.com.br>
Message-ID: <Pine.BSF.4.21.0102271834090.640-100000@granch.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

 Because there is no stable linux-2.4 version of sbni driver at the moment
 (2.2 driver that comes with 2.4 kernel doesn't working) i dont think
 there is a need in this patch for current kernels. But I'll surely made
 these changes in 2.4 driver before releasing. 
 Thanks for ideas.

                                       .
	       Better the devil you know than the devil you don't
                          Granch ltd.  Security Analyst

