Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135936AbREBVHx>; Wed, 2 May 2001 17:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135958AbREBVGt>; Wed, 2 May 2001 17:06:49 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32018 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135908AbREBVFG>; Wed, 2 May 2001 17:05:06 -0400
Subject: Re: Logging kernel oops
To: joe.mathewson@btinternet.com
Date: Wed, 2 May 2001 22:09:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200105021957.f42JvH511805@localhost.localdomain> from "Joseph Mathewson" at May 02, 2001 08:57:16 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14v3rs-0004Lw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What is the preferred what of getting debugging information from a kernel
> oops?  Is my only way connecting a monitor and getting a pencil and paper? 
> Is there any conceivable way I can get some useful debugging information
> (on reset) without plugging in a keyboard/monitor?

You can build and boot a kernel with serial console and run a serial cable to
another box
