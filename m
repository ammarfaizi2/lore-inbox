Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281779AbRKZPXw>; Mon, 26 Nov 2001 10:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281766AbRKZPXd>; Mon, 26 Nov 2001 10:23:33 -0500
Received: from bashir.Belgium.EU.net ([193.74.208.147]:4518 "EHLO
	bashir.belgium.eu.net") by vger.kernel.org with ESMTP
	id <S281773AbRKZPXU>; Mon, 26 Nov 2001 10:23:20 -0500
Date: Mon, 26 Nov 2001 17:23:09 +0200
From: Ward Vandewege <ward@pong.be>
To: =?iso-8859-1?Q?Fran=E7ois_Cami?= <stilgar2k@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in kernel 2.4.x with x>=12
Message-ID: <20011126172309.A5368@countzero.vandewege.net>
Mail-Followup-To: Ward Vandewege <ward@pong.be>,
	=?iso-8859-1?Q?Fran=E7ois_Cami?= <stilgar2k@wanadoo.fr>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011126145505.A3783@countzero.vandewege.net> <3C023E74.8090303@wanadoo.fr> <20011126154626.A4119@countzero.vandewege.net> <3C024A98.50506@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C024A98.50506@wanadoo.fr>; from stilgar2k@wanadoo.fr on Mon, Nov 26, 2001 at 02:58:48PM +0100
X-URL: http://pong.be/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 02:58:48PM +0100, François Cami wrote:
> Ward Vandewege wrote:
> 
> > This seems to suggest there is a problem in the Athlon/Duron optimization code.
> 
> As a matter of fact the problem seems to be more with the KT133/KT133A
> chipset, than with the Athlon/Duron optimization code.
> 
> I'm nearly sure that compiling for K6 or i586 (the MMX one)
> would work fine, too, and it will beat a 386 kernel hands down.

Confirmed. 2.4.16-pre1 works just fine on my Duron, when compiled for K6.

I'm now compiling 2.4.16 - it's a busy day for gcc :-)

Bye for now,
Ward.

-- 
Pong.be         -(   "If you think penguins are fat and waddle, you have   )-
Virtual hosting -( never been attacked by one running at you in excess of  )-
http://pong.be  -(                   100 MPH." -- Linus                    )-
