Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129678AbQKOVpc>; Wed, 15 Nov 2000 16:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129658AbQKOVpW>; Wed, 15 Nov 2000 16:45:22 -0500
Received: from 13dyn206.delft.casema.net ([212.64.76.206]:44804 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129891AbQKOVpE>; Wed, 15 Nov 2000 16:45:04 -0500
Message-Id: <200011152114.WAA06084@cave.bitwizard.nl>
Subject: Re: test11-pre5, Athlon, and Machine Check Architecture
In-Reply-To: <8uuqij$ejs$1@cesium.transmeta.com> from "H. Peter Anvin" at "Nov
 15, 2000 12:09:55 pm"
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 15 Nov 2000 22:14:44 +0100 (MET)
CC: linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> crash; I don't expect anyone to actually see an #MF exception in real
> life.  I'm trying to get confirmation from AMD that the code should
> be correct even for Athlon.

Peter, 

Would it be an idea to invite people to lower the voltage on their 
CPUs a bit, to try and trigger #MF's?

(I started thinking about slowly overclocking the CPUs, to try and
trigger them, but that's not neccesary. At lower voltages, you'll also
get errors, but shouldn't risk smoking your CPU.... )

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
*       Common sense is the collection of                                *
******  prejudices acquired by age eighteen.   -- Albert Einstein ********
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
