Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131414AbQKXAOt>; Thu, 23 Nov 2000 19:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131403AbQKXAOm>; Thu, 23 Nov 2000 19:14:42 -0500
Received: from 13dyn232.delft.casema.net ([212.64.76.232]:63499 "EHLO
        abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
        id <S131226AbQKXAOc>; Thu, 23 Nov 2000 19:14:32 -0500
Message-Id: <200011232343.AAA02174@cave.bitwizard.nl>
Subject: Re: [NEW DRIVER] firestream
In-Reply-To: <Pine.LNX.4.21.0011232059560.496-100000@tricky> from Bartlomiej
 Zolnierkiewicz at "Nov 23, 2000 11:19:16 pm"
To: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
Date: Fri, 24 Nov 2000 00:43:55 +0100 (MET)
CC: Patrick van de Lageweg <patrick@bitwizard.nl>,
        Rogier Wolff <wolff@bitwizard.nl>, linux-kernel@vger.kernel.org
From: R.E.Wolff@bitwizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> You may also consider processing firestream.[ch] through indent because
> spacing is inconsistent - sometimes tabs, sometimes 8*space (it would
> be nice too have tabs everywhere).

As far as I know the tabs/spaces are exactly the way I want them. 

There are tabs for the number of indentation levels. From then on
there are only spaces.

Although the "kernel-rules" say that tabs are 8 spaces, if you set
your tabsize to 4, my sources should still be nicely formatted.  If
I'd perform your substitute it wouldn't. 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
