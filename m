Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274871AbRIZIHU>; Wed, 26 Sep 2001 04:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274873AbRIZIHA>; Wed, 26 Sep 2001 04:07:00 -0400
Received: from pa147.antoniuk.sdi.tpnet.pl ([213.25.59.147]:8322 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S274871AbRIZIGz>; Wed, 26 Sep 2001 04:06:55 -0400
Date: Wed, 26 Sep 2001 10:05:02 +0200
From: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jpopl@interia.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Bad, bad, bad VM behaviour in 2.4.10
Message-ID: <20010926100502.A2824@localhost.localdomain>
In-Reply-To: <3BB0F483.69929A79@ditec.um.es> <Pine.LNX.4.21.0109251702240.2193-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.21.0109251702240.2193-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Sep 25, 2001 at 05:03:35PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 05:03:35PM -0300, Marcelo Tosatti wrote:
> I need some information which may help confirm a guess of mine:
> 
> Do you have swap available ?
> 
> If so, there was available anonymous memory to be swapped out ?

As I wrote before - on my system this problem appear even when swap is on, and
there is enough swap, but not enought RAM (i.e. when system just starts using
swap...).

