Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262268AbRENRFr>; Mon, 14 May 2001 13:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262275AbRENRFh>; Mon, 14 May 2001 13:05:37 -0400
Received: from hera.cwi.nl ([192.16.191.8]:31177 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262268AbRENRFX>;
	Mon, 14 May 2001 13:05:23 -0400
Date: Mon, 14 May 2001 19:05:19 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105141705.TAA09642.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk
Subject: Re: Minor numbers
Cc: R.E.Wolff@bitwizard.nl, aqchen@us.ibm.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The fs and stat structs are set up to allow 32bits.
> 64bits is a major exercise

No. Inside the kernel the dev_t type does not really occur.
The exercise is essentially the patch that I sent last month or so.

Andries
