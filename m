Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312740AbSCZViR>; Tue, 26 Mar 2002 16:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312746AbSCZViH>; Tue, 26 Mar 2002 16:38:07 -0500
Received: from hera.cwi.nl ([192.16.191.8]:57537 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S312740AbSCZVhy>;
	Tue, 26 Mar 2002 16:37:54 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 26 Mar 2002 21:37:46 GMT
Message-Id: <UTC200203262137.VAA421173.aeb@cwi.nl>
To: alan@lxorguk.ukuu.org.uk, jholly@cup.hp.com
Subject: Re: readv() return and errno
Cc: Andries.Brouwer@cwi.nl, balbir_soni@yahoo.com,
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
        plars@austin.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The man page is buggy if anything is.

Hmm. So far nobody pointed out anything buggy.
Now that I look myself I see outdated prototypes
(like int instead of ssize_t).
What else did you find buggy?

Andries
