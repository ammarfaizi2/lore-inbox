Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132862AbRDIWYT>; Mon, 9 Apr 2001 18:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132863AbRDIWYJ>; Mon, 9 Apr 2001 18:24:09 -0400
Received: from mail.zmailer.org ([194.252.70.162]:61450 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S132862AbRDIWX5>;
	Mon, 9 Apr 2001 18:23:57 -0400
Date: Tue, 10 Apr 2001 01:23:37 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: goodbye
Message-ID: <20010410012337.Z805@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.21.0104031800030.14090-100000@imladris.rielhome.conectiva> <986844003.21377.12.camel@mistress> <9at9sc$kva$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9at9sc$kva$1@forge.intermeta.de>; from hps@intermeta.de on Mon, Apr 09, 2001 at 09:34:04PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2001 at 09:34:04PM +0000, Henning P. Schmiedehausen wrote:
> Michael Peddemors <michael@linuxmagic.com> writes:
> 
> >Uh... use their ISP relay service anyway???
> >I take my laptop all over, to lot's of my clients locations, and if I
> >could relay through their servers, then I had better give them some good
> >advice.. Some places I just pick an available IP and it might not be in
> >the allowed relay list.  And this happens when I am in M$ or Linux..
> 
> So, Mr. Admin, setup your laptop to use SSL to your SMTP and POP
> server and authenticate with a client side certificate on your
> laptop. Welcome to the 21st century. You may, however, need a little
> more infrastructure than you can pull from your favourite distribution
> box.

        RFC 2487        STARTTLS
        RFC 2554        SMTP-Auth, + M$ Exchange / + Netscape
                        ( + a bunch of other authenticator methods )

        Under encryption, plaintext username + password login.
        The IETF protocols DO NOT support plaintext login for
        obvious security reasons.

        No hazzles about autenticating by certificates.

        Availability of the feature is probably excidingly rare..

> 	Regards
> 		Henning
> -- 
> Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
> INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

/Matti Aarnio
