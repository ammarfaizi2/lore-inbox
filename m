Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268577AbRHKQnV>; Sat, 11 Aug 2001 12:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268570AbRHKQnM>; Sat, 11 Aug 2001 12:43:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36104 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268567AbRHKQm7>; Sat, 11 Aug 2001 12:42:59 -0400
Subject: Re: VM nuisance
To: david@blue-labs.org (David Ford)
Date: Sat, 11 Aug 2001 17:45:09 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hpa@zytor.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "David Ford" at Aug 11, 2001 11:39:52 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Vbsr-0002vi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - How hard/how much time.. to implement resource baselines (or similar 
> concept)

Ben La Haise has been working on that part of things. Its non trivial. I've
been discussing changes with Rik for VM behaviour shifts when thrashing but
not OOM. We have some ideas but this is research
