Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130027AbQLMBRO>; Tue, 12 Dec 2000 20:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130668AbQLMBRF>; Tue, 12 Dec 2000 20:17:05 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:13065 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130027AbQLMBQy>; Tue, 12 Dec 2000 20:16:54 -0500
Date: Tue, 12 Dec 2000 18:41:43 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Dominik Kubla <dominik.kubla@uni-mainz.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18-25 DELL Laptop Video Problems
Message-ID: <20001212184143.A12104@vger.timpanogas.org>
In-Reply-To: <20001209160027.A15007@vger.timpanogas.org> <E144sZd-0005q5-00@the-village.bc.nu> <20001209181351.C15531@vger.timpanogas.org> <20001210174906.B2161@uni-mainz.de> <20001210155016.A19788@vger.timpanogas.org> <20001211082646.B4646@uni-mainz.de> <20001211111141.A3443@vger.timpanogas.org> <20001213013446.A13808@uni-mainz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001213013446.A13808@uni-mainz.de>; from dominik.kubla@uni-mainz.de on Wed, Dec 13, 2000 at 01:34:46AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2000 at 01:34:46AM +0100, Dominik Kubla wrote:
> On Mon, Dec 11, 2000 at 11:11:41AM -0700, Jeff V. Merkey wrote:
> ...
> > Then this is the vga=271 stuff?
> > 
> > Jeff 
> 
> No, that's just selecting the VGA resolution. I am referring to the
> video parameter:
> 
>   video=<driver>:<option>[,<option>,...]
> 
> Look at linux/Dokumentation/fb/modedb.txt.
> 
> Yours,
>   Dominik Kubla

Thanks!  I will.   I did have VESA FB enabled, BTW and I still see the 
problem.

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
