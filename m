Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278768AbRJZR2b>; Fri, 26 Oct 2001 13:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278770AbRJZR2U>; Fri, 26 Oct 2001 13:28:20 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11020 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278768AbRJZR2H>; Fri, 26 Oct 2001 13:28:07 -0400
Subject: Re: Linux 2.4.13-ac1
To: cswingle@iarc.uaf.edu (Christopher S. Swingley)
Date: Fri, 26 Oct 2001 18:35:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011026092359.A9384@iarc.uaf.edu> from "Christopher S. Swingley" at Oct 26, 2001 09:23:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15xAso-0000mW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does this mean the ac tree now uses the AA VM, or is this a merge
> with everything but the VM, like the earlier 2.4.1x-ac trees?

It still uses buffer cache based raw disk access (so things like DVD players
actually work ok) and the Riel VM. The way things are panning out I suspect
2.4.14ac* may well be a point I switch to the Andrea/Marcelo/Linus VM.

Alan
