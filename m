Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131763AbQKROHR>; Sat, 18 Nov 2000 09:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131789AbQKROHI>; Sat, 18 Nov 2000 09:07:08 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:40201 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S131763AbQKROHC>;
	Sat, 18 Nov 2000 09:07:02 -0500
Date: Sat, 18 Nov 2000 14:36:48 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: "SubmittingPatches" text
Message-ID: <20001118143648.C23033@almesberger.net>
In-Reply-To: <E13wX8W-0008Qt-00@the-village.bc.nu> <200011181016.LAA12939@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200011181016.LAA12939@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Sat, Nov 18, 2000 at 11:16:15AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
> I'd say DO CC Linux-kernel, don't CC Linus. 

Agreed. Posting to linux-kernel (as opposed to only the maintainer and/or
Linus) serves the following purposes:

 - For patches introducing new features or changing existing ones,
   this exposes them to public review. (Every once in a while, even
   seemingly trivial and harmless patches are found to be wrong.)
 - For patches fixing problems, this confirms the existence of the
   problem to people who are dimly aware of it, it provides a possible
   solution to those looking for one, and it tells those who are trying
   to fix it that somebody else is already working on it.

Concerning Cc to Linus, well, I'd be surprised if he's dying to get
more mail of the "FYI" type ;-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
