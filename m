Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262088AbRENMnA>; Mon, 14 May 2001 08:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262061AbRENMmu>; Mon, 14 May 2001 08:42:50 -0400
Received: from pc1-hems4-0-cust171.bre.cable.ntl.com ([213.105.88.171]:40431
	"HELO rhirst.linuxcare.com") by vger.kernel.org with SMTP
	id <S262051AbRENMmo>; Mon, 14 May 2001 08:42:44 -0400
Date: Mon, 14 May 2001 13:41:29 +0100
From: Richard Hirst <rhirst@linuxcare.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andries.Brouwer@cwi.nl, James.Bottomley@HansenPartnership.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [NEW SCSI DRIVER] for 53c700 chip and NCR_D700 card against 2.4.4
Message-ID: <20010514134129.C24646@linuxcare.com>
In-Reply-To: <UTC200105132143.XAA39600.aeb@vlet.cwi.nl> <E14z4XR-00071u-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0us
In-Reply-To: <E14z4XR-00071u-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, May 13, 2001 at 11:40:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 11:40:33PM +0100, Alan Cox wrote:
> > If I am not mistaken, Richard Hirst has also done work on this thing.
> 
> He did 53c710+. The 700 and 700/66 are much less capable devices.

I did 53c700 as well, in the parisc-linux tree.  Sounds like James'
driver is more featureful than mine though.

Richard
