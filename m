Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130736AbRBLWJO>; Mon, 12 Feb 2001 17:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131597AbRBLWJE>; Mon, 12 Feb 2001 17:09:04 -0500
Received: from fisica.ufpr.br ([200.17.209.129]:39930 "EHLO
	hoggar.fisica.ufpr.br") by vger.kernel.org with ESMTP
	id <S130736AbRBLWIc>; Mon, 12 Feb 2001 17:08:32 -0500
From: Carlos Carvalho <carlos@fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14984.24279.786295.783864@hoggar.fisica.ufpr.br>
Date: Mon, 12 Feb 2001 20:08:23 -0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.19pre10 doesn't compile on alphas (sunrpc)
In-Reply-To: <E14SQqi-0008Bm-00@the-village.bc.nu>
In-Reply-To: <14984.18005.694178.241076@hoggar.fisica.ufpr.br>
	<E14SQqi-0008Bm-00@the-village.bc.nu>
X-Mailer: VM 6.90 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox (alan@lxorguk.ukuu.org.uk) wrote on 12 February 2001 21:49:
 >The ideal solution would be for someone to provide BUG() on the
 >Alpha platform as in 2.4. That would sort things cleanly

Hmm... Looks more difficult than I expected. Can we just change the
one call to BUG to something sensible on alphas? I'm really eager to
run this kernel..
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
