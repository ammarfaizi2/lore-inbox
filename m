Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275803AbRI1Ch4>; Thu, 27 Sep 2001 22:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275804AbRI1Chr>; Thu, 27 Sep 2001 22:37:47 -0400
Received: from logic.net ([64.81.146.141]:5367 "HELO logic.net")
	by vger.kernel.org with SMTP id <S275803AbRI1Che>;
	Thu, 27 Sep 2001 22:37:34 -0400
Date: Thu, 27 Sep 2001 21:38:00 -0500
From: "Edward S. Marshall" <esm@logic.net>
To: Fabbione <fabbione@fabbione.net>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
Message-ID: <20010927213800.A1864@labyrinth.local>
In-Reply-To: <20010924124044.B17377@devserv.devel.redhat.com> <3BB0B43B.38EF26A3@fabbione.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BB0B43B.38EF26A3@fabbione.net>; from fabbione@fabbione.net on Tue, Sep 25, 2001 at 06:43:39PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 06:43:39PM +0200, Fabbione wrote:
> You can probably add mvfs ClearCase file system but I don't remember the
> URL.

http://www.rational.com/ is the corporate website, and the particular product
is at http://www.rational.com/products/clearcase/ .

The actual module is an implementation of the Rational (previously Atria)
ClearCase mvfs filesystem for Linux; it is composed of a source-available
translation layer, and a binary-only core.

One important note to mention: they only support Red Hat-supplied kernels;
there is a high chance of failure using it with a stock kernel, due to
changes in internal structures required by mvfs.

-- 
Edward S. Marshall <esm@logic.net>                        http://esm.logic.net/
-------------------------------------------------------------------------------
[                  Felix qui potuit rerum cognoscere causas.                  ]
