Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263442AbRFAJy7>; Fri, 1 Jun 2001 05:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263443AbRFAJyt>; Fri, 1 Jun 2001 05:54:49 -0400
Received: from indyio.rz.uni-sb.de ([134.96.7.3]:11860 "EHLO
	indyio.rz.uni-sb.de") by vger.kernel.org with ESMTP
	id <S263442AbRFAJyj>; Fri, 1 Jun 2001 05:54:39 -0400
Message-ID: <3B176653.B4FD0621@stud.uni-saarland.de>
Date: Fri, 01 Jun 2001 09:54:27 +0000
From: Studierende der Universitaet des Saarlandes 
	<masp0008@stud.uni-sb.de>
Reply-To: manfred@colorfullife.com
Organization: Studierende Universitaet des Saarlandes
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.0.36 i686)
MIME-Version: 1.0
To: jgarzik@mandrakesoft.com
CC: linux-kernel@vger.kernel.org, thockin@sun.com
Subject: Re: [PATCH] sym53c8xx timer and smp fixes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff wrote:
>
> so, this driver is mixed spinlocks and save/restore_flags? Any
> chance this can be converted to all spinlocks? 
>
It's spinlock for 2.2 and 2.4 kernels, and save_flags for 2.0.

Tim, did you cc Gerard Roudier? He mainains the sym53c8xx driver. All
mail archives strip the cc list :-(

--
	Manfred
