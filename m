Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282221AbRK2Afd>; Wed, 28 Nov 2001 19:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282222AbRK2AfX>; Wed, 28 Nov 2001 19:35:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58386 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282221AbRK2AfK>; Wed, 28 Nov 2001 19:35:10 -0500
Subject: Re: 2.5.1-pre3 Build Failure
To: V64@Galaxy42.com (Jahn Veach)
Date: Thu, 29 Nov 2001 00:43:40 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <009101c1786d$3809a890$03910404@Molybdenum> from "Jahn Veach" at Nov 28, 2001 06:31:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169FIi-0006i5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Seems I'm not the only one with this problem either.

There are a lot of broken things in pre3 - seems someone applied the
locking patch without fixing it first.
