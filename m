Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316891AbSF0RW1>; Thu, 27 Jun 2002 13:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316892AbSF0RW0>; Thu, 27 Jun 2002 13:22:26 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56838 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316891AbSF0RW0>; Thu, 27 Jun 2002 13:22:26 -0400
Subject: Re: another way to activate AMD disconnect on VIA KT266 (aka cooling bits)
To: utx@penguin.cz (Stanislav Brabec)
Date: Thu, 27 Jun 2002 18:31:08 +0100 (BST)
Cc: nofftz@castor.uni-trier.de (Daniel Nofftz), linux-kernel@vger.kernel.org
In-Reply-To: <20020626212659.GA3565@utx.vol.cz> from "Stanislav Brabec" at Jun 26, 2002 11:27:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17Nd6q-0005Tq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For unknown reasons, the system is stable only for whole number in
> processor multiplier. For half-number multiplier system sometimes
> crashes.

See the CPU errata document - that one is known
