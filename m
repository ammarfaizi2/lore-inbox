Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277842AbRJWQKz>; Tue, 23 Oct 2001 12:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277859AbRJWQKp>; Tue, 23 Oct 2001 12:10:45 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33798 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277842AbRJWQKh>; Tue, 23 Oct 2001 12:10:37 -0400
Subject: Re: Problems: Kernel v2.4.12 + agpgart + XF86 4.1.0
To: nick@coelacanth.com (Nick Papadonis)
Date: Tue, 23 Oct 2001 17:17:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m33d4ayk5c.fsf@coelacanth.com> from "Nick Papadonis" at Oct 23, 2001 01:56:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15w4Eh-0006Pn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The Fix:
> Compile AGPGART + i810 video as modules.

What do the dmesg messages and X log show in the failing case ?
