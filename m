Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281180AbRKLAHf>; Sun, 11 Nov 2001 19:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281183AbRKLAHZ>; Sun, 11 Nov 2001 19:07:25 -0500
Received: from theirongiant.zip.net.au ([61.8.0.198]:41422 "EHLO
	theirongiant.zip.net.au") by vger.kernel.org with ESMTP
	id <S281180AbRKLAHW>; Sun, 11 Nov 2001 19:07:22 -0500
Date: Mon, 12 Nov 2001 11:06:32 +1100
From: CaT <cat@zip.com.au>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: Anton Altaparmakov <aia21@cus.cam.ac.uk>,
        "Michael H. Warfield" <mhw@wittsend.com>, lobo@polbox.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC-ONT (on topic)] Modprobe enhancement (was Re:  "Dance of the Trolls")
Message-ID: <20011112110632.D991@zip.com.au>
In-Reply-To: <Pine.SOL.3.96.1011111120107.21134C-100000@libra.cus.cam.ac.uk> <004601c16b0b$8b04bb80$f5976dcf@nwfs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004601c16b0b$8b04bb80$f5976dcf@nwfs>
User-Agent: Mutt/1.3.23i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2001 at 04:49:46PM -0700, Jeff V. Merkey wrote:
> Anton,
> 
> This is a great suggestion.  You should ping Keith Owens (does he own
> modutils, I think so) and make it happen.  A much desireable change.

Only if you can turn it off (ie a -[Yy] flag) as I don't really want my
boot sequence to hang just because I bought a geforce card so that I
could play my 3d games nice and fast.

And well, since you may need to turn it off so that your boot sequence
doesn't hang (and more often then not that's where you'll first install
the module) then it makes the option rather useless.

Then there's the autoload feature. Do I really want to have my
mount /cdrom command hang on me because somewhere something wants to ask
me a question? Will this all be interfaced with X so that a prompt comes
up?

Again, you'd wind up turning it off which makes it less useful still.

(Unless, ofcourse, I'm missing something)

-- 
CaT        "As you can expect it's really affecting my sex life. I can't help
           it. Each time my wife initiates sex, these ejaculating hippos keep
           floating through my mind."
                - Mohd. Binatang bin Goncang, Singapore Zoological Gardens
