Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280941AbRKCLPR>; Sat, 3 Nov 2001 06:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280942AbRKCLPH>; Sat, 3 Nov 2001 06:15:07 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:13579 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S280941AbRKCLO6>; Sat, 3 Nov 2001 06:14:58 -0500
Date: Sat, 3 Nov 2001 12:14:55 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx 6.2.1 unstable?
Message-ID: <20011103121455.D2861@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3BE18244.9AB8A602@internet-factory.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3BE18244.9AB8A602@internet-factory.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Nov 2001, Holger Lubitz wrote:

> so, after nearly half a year without problems, i was reluctant to update
> the aic driver again, but was trying nevertheless because of the
> security fixes in recent kernels, which i considered "nice to have".
> however, version 6.2.1 of the adaptec driver seems to have broken the
> setup once again. i'm back to 2.4.8 for now.

I had some persistent difficulties (strange messages on bootup, but
otherwise fine operation) with 6.2.1 which went away when I upgraded to
6.2.4. This is not exactly helpful because you just don't play games on
a production machine, but might be a hint nonetheless. I'm currently
running 2.4.12-ac6 with some netfilter updates on my machines because
the SuSE 2.4.10 kernel that ships with 7.3 froze solid on at least two
machines for reasons I cannot tell.

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
