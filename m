Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265987AbRF1PWq>; Thu, 28 Jun 2001 11:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265988AbRF1PWg>; Thu, 28 Jun 2001 11:22:36 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25869 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265987AbRF1PW3>; Thu, 28 Jun 2001 11:22:29 -0400
Subject: Re: A signal fairy tale
To: dmaas@dcine.com (Dan Maas)
Date: Thu, 28 Jun 2001 16:21:49 +0100 (BST)
Cc: vii@users.sourceforge.net (John Fremlin), linux-kernel@vger.kernel.org
In-Reply-To: <00b101c0ffe2$fb77ad30$0701a8c0@morph> from "Dan Maas" at Jun 28, 2001 10:59:50 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Fdc5-00075e-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> admit that UNIX has a crappy event model, and implement something like Win32
> GetMessage =)...

Thats a subset of the real time signal model already in Linux. Just block the
signal and wait for it..
