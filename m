Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129866AbQLMBFo>; Tue, 12 Dec 2000 20:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130321AbQLMBFe>; Tue, 12 Dec 2000 20:05:34 -0500
Received: from sundiver.zdv.Uni-Mainz.DE ([134.93.174.136]:36612 "HELO
	gateway.intern.kubla.de") by vger.kernel.org with SMTP
	id <S129866AbQLMBFW>; Tue, 12 Dec 2000 20:05:22 -0500
Date: Wed, 13 Dec 2000 01:34:46 +0100
From: Dominik Kubla <dominik.kubla@uni-mainz.de>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18-25 DELL Laptop Video Problems
Message-ID: <20001213013446.A13808@uni-mainz.de>
Mail-Followup-To: Dominik Kubla <dominik.kubla@uni-mainz.de>,
	"Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20001209160027.A15007@vger.timpanogas.org> <E144sZd-0005q5-00@the-village.bc.nu> <20001209181351.C15531@vger.timpanogas.org> <20001210174906.B2161@uni-mainz.de> <20001210155016.A19788@vger.timpanogas.org> <20001211082646.B4646@uni-mainz.de> <20001211111141.A3443@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001211111141.A3443@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Mon, Dec 11, 2000 at 11:11:41AM -0700
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2000 at 11:11:41AM -0700, Jeff V. Merkey wrote:
...
> Then this is the vga=271 stuff?
> 
> Jeff 

No, that's just selecting the VGA resolution. I am referring to the
video parameter:

  video=<driver>:<option>[,<option>,...]

Look at linux/Dokumentation/fb/modedb.txt.

Yours,
  Dominik Kubla
-- 
Drug misuse is not  a disease, it is a decision, like  the decision to step
out in  front of a  moving car. You  would call that  not a disease  but an
error of judgment.  --Philip K. Dick. Author's Note, A SCANNER DARKLY, 1977
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
