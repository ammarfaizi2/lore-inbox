Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131254AbQLJRUG>; Sun, 10 Dec 2000 12:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131523AbQLJRT4>; Sun, 10 Dec 2000 12:19:56 -0500
Received: from sundiver.zdv.Uni-Mainz.DE ([134.93.174.136]:3588 "HELO
	gateway.intern.kubla.de") by vger.kernel.org with SMTP
	id <S131254AbQLJRTo>; Sun, 10 Dec 2000 12:19:44 -0500
Date: Sun, 10 Dec 2000 17:49:06 +0100
From: Dominik Kubla <dominik.kubla@uni-mainz.de>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18-25 DELL Laptop Video Problems
Message-ID: <20001210174906.B2161@uni-mainz.de>
Mail-Followup-To: Dominik Kubla <dominik.kubla@uni-mainz.de>,
	"Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20001209160027.A15007@vger.timpanogas.org> <E144sZd-0005q5-00@the-village.bc.nu> <20001209181351.C15531@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001209181351.C15531@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Sat, Dec 09, 2000 at 06:13:51PM -0700
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the VESA fb driver instead of the ATI fb driver. I have been doing so
ever since i got my DELL Inspiron 7500: the ATI driver won't recognize the
Rage Mobility chips (well, i could convince it to do so but the 1400x1050
LCD panel timing never worked...)

Dominik
-- 
Drug misuse is not  a disease, it is a decision, like  the decision to step
out in  front of a  moving car. You  would call that  not a disease  but an
error of judgment.  --Philip K. Dick. Author's Note, A SCANNER DARKLY, 1977
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
