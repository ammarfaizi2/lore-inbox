Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277382AbRKTIr3>; Tue, 20 Nov 2001 03:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279840AbRKTIrU>; Tue, 20 Nov 2001 03:47:20 -0500
Received: from mail.wave.co.nz ([203.96.216.11]:13940 "EHLO mail.wave.co.nz")
	by vger.kernel.org with ESMTP id <S277382AbRKTIrI>;
	Tue, 20 Nov 2001 03:47:08 -0500
Date: Tue, 20 Nov 2001 21:47:04 +1300
From: Mark van Walraven <markv@wave.co.nz>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reformat mtrr.c to conform to CodingStyle
Message-ID: <20011120214703.A26799@mail.wave.co.nz>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011112232539.A14409@redhat.com> <20011113121022.L1778@lynx.no> <20011114085714.V17761@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20011114085714.V17761@khan.acc.umu.se>; from David Weinehall on Wed, Nov 14, 2001 at 08:57:14AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 08:57:14AM +0100, David Weinehall wrote:
> 	switch (option) {
> 	case 1: 
> 		/* blaha */
> 
> 
> That feels kind of odd compared to the rest of the codingstyle.
> 
> Comments?!

A case statement is a label, therefore "outdented" on level.

Regards,

Mark.
