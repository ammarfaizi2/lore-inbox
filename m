Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281248AbRKZAFt>; Sun, 25 Nov 2001 19:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281241AbRKZAFi>; Sun, 25 Nov 2001 19:05:38 -0500
Received: from [212.18.232.186] ([212.18.232.186]:18441 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S281237AbRKZAFc>; Sun, 25 Nov 2001 19:05:32 -0500
Date: Mon, 26 Nov 2001 00:05:02 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: Tom Eastep <teastep@shorewall.net>,
        Hartmut Holz <hartmut.holz@arcormail.de>, linux-kernel@vger.kernel.org
Subject: Re: Input/output error
Message-ID: <20011126000502.A25016@flint.arm.linux.org.uk>
In-Reply-To: <20011123191025.D74BDAD02@mail.shorewall.net> <200111252250.fAPMo7wM012678@sleipnir.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111252250.fAPMo7wM012678@sleipnir.valparaiso.cl>; from vonbrand@sleipnir.valparaiso.cl on Sun, Nov 25, 2001 at 07:50:06PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2001 at 07:50:06PM -0300, Horst von Brand wrote:
> > > Entry 'network' in /lock/subsys (30001) has deleted/unused inode 30006.
> > >   Clear? yes
> 
> [Ad nauseam]
> 
> Saw this with 2.4.15pre[89]

This is the FS bug that Al Viro has fixed for 2.4.15/2.5.0.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

