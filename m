Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129090AbRBAGBS>; Thu, 1 Feb 2001 01:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129081AbRBAGBJ>; Thu, 1 Feb 2001 01:01:09 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:11087 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129044AbRBAGA5>; Thu, 1 Feb 2001 01:00:57 -0500
Date: Wed, 31 Jan 2001 21:56:03 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jamie Lokier <ln@tantalophile.demon.co.uk>
Cc: Andi Kleen <ak@muc.de>, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        John Fremlin <vii@altern.org>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com, paulus@linuxcare.com, linux-ppp@vger.kernel.org,
        linux-net@vger.kernel.org
Subject: Re: [PATCH] dynamic IP support for 2.4.0 (SIOCKILLADDR)
Message-ID: <20010131215602.K874@bacchus.dhis.org>
In-Reply-To: <m2d7d838sj.fsf@boreas.yi.org.> <200101290245.f0T2j2Y438757@saturn.cs.uml.edu> <20010129135905.B1591@fred.local> <20010129193136.A11035@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010129193136.A11035@pcep-jamie.cern.ch>; from ln@tantalophile.demon.co.uk on Mon, Jan 29, 2001 at 07:31:36PM +0100
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2001 at 07:31:36PM +0100, Jamie Lokier wrote:

> Unfortunately getting the same IP is rare now, so I've been toying with

Pretty much dependant of the type of equipment and the configuration used
at the ISP's servers.  I use two ISPs when I'm back in Germany of which
the one always and the other one never gives me the same IP when I
reconnect within some short time.

(Guess which one I prefer ...)

  Ralf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
