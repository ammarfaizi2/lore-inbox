Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133054AbQLJWZ3>; Sun, 10 Dec 2000 17:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132565AbQLJWZT>; Sun, 10 Dec 2000 17:25:19 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:47368 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S132106AbQLJWZN>; Sun, 10 Dec 2000 17:25:13 -0500
Date: Sun, 10 Dec 2000 15:50:16 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Dominik Kubla <dominik.kubla@uni-mainz.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18-25 DELL Laptop Video Problems
Message-ID: <20001210155016.A19788@vger.timpanogas.org>
In-Reply-To: <20001209160027.A15007@vger.timpanogas.org> <E144sZd-0005q5-00@the-village.bc.nu> <20001209181351.C15531@vger.timpanogas.org> <20001210174906.B2161@uni-mainz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001210174906.B2161@uni-mainz.de>; from dominik.kubla@uni-mainz.de on Sun, Dec 10, 2000 at 05:49:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2000 at 05:49:06PM +0100, Dominik Kubla wrote:
> Use the VESA fb driver instead of the ATI fb driver. I have been doing so
> ever since i got my DELL Inspiron 7500: the ATI driver won't recognize the
> Rage Mobility chips (well, i could convince it to do so but the 1400x1050
> LCD panel timing never worked...)
> 
> Dominik

Can you enable both at the same time?  It's an installer issue with laptops
and I need tobe able to detect whatever is running.

:-)

Jeff


> -- 
> Drug misuse is not  a disease, it is a decision, like  the decision to step
> out in  front of a  moving car. You  would call that  not a disease  but an
> error of judgment.  --Philip K. Dick. Author's Note, A SCANNER DARKLY, 1977
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
