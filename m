Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLAQK7>; Fri, 1 Dec 2000 11:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbQLAQKj>; Fri, 1 Dec 2000 11:10:39 -0500
Received: from zeus.kernel.org ([209.10.41.242]:59143 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129183AbQLAQKf>;
	Fri, 1 Dec 2000 11:10:35 -0500
Message-Id: <200012011539.QAA22355@cave.bitwizard.nl>
Subject: Re: [PATCH] rio
In-Reply-To: <Pine.LNX.4.21.0012011334440.5601-100000@panoramix.bitwizard.nl>
 from Patrick van de Lageweg at "Dec 1, 2000 01:40:49 pm"
To: Patrick van de Lageweg <patrick@bitwizard.nl>
Date: Fri, 1 Dec 2000 16:39:41 +0100 (MET)
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rogier Wolff <wolff@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: R.E.Wolff@bitwizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick van de Lageweg wrote:
> Hi alan,
> 
> This patches fixes several isues with the rio driver:
> 
>  - Implemented breaks
>  - Fixed a DCD up/down crash
>  - Added kmalloc return value check

Hmm. And introduces a new problem. Sorry. Please ignore this patch...

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
