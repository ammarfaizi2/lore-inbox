Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273976AbRJYRJo>; Thu, 25 Oct 2001 13:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273904AbRJYRJf>; Thu, 25 Oct 2001 13:09:35 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18449 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273976AbRJYRJP>; Thu, 25 Oct 2001 13:09:15 -0400
Subject: Re: kernel compiler
To: lostlogic@toughguy.net (Lost Logic)
Date: Thu, 25 Oct 2001 18:16:15 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BD841B7.5060405@toughguy.net> from "Lost Logic" at Oct 25, 2001 11:45:43 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wo76-0005TI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> GCC 3.0 Produces slower code, eh?  I was of the understanding that it 
> contained many more optimizations than previous versions...???

It does - but the end result right now is typically slower. it has the
infrastructure and optimisation code to create faster code than 2.x ever
could but it isnt yet at the point it has been refined to do so
