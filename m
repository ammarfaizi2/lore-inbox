Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277054AbRJQSuX>; Wed, 17 Oct 2001 14:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277055AbRJQSuN>; Wed, 17 Oct 2001 14:50:13 -0400
Received: from ns.suse.de ([213.95.15.193]:28171 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S277054AbRJQSuE> convert rfc822-to-8bit;
	Wed, 17 Oct 2001 14:50:04 -0400
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Making diff(1) of linux kernels faster
In-Reply-To: <Pine.LNX.4.33.0110140841540.15323-100000@penguin.transmeta.com>
	<3BCAB9B1.2F85F523@yahoo.com>
X-Yow: I'm ANN LANDERS!!  I can SHOPLIFT!!
From: Andreas Schwab <schwab@suse.de>
Date: 17 Oct 2001 20:50:36 +0200
In-Reply-To: <3BCAB9B1.2F85F523@yahoo.com> (Paul Gortmaker's message of "Wed, 17 Oct 2001 08:25:53 -0400")
Message-ID: <jeadyq6qyr.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.107
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Gortmaker <p_gortmaker@yahoo.com> writes:

|> This was all running under a 2.2.x kernel btw; might have time to 
|> test on a 2.4.x one later.  Either way, it kind of makes you wonder 
|> why nobody had done this earlier

What's wrong with running find on the tree first?  IMHO there is no need
to introduce an obscure option if there is already a working alternative.

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
