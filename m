Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310314AbSCAB4x>; Thu, 28 Feb 2002 20:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310252AbSCAByi>; Thu, 28 Feb 2002 20:54:38 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:24565
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S310306AbSCABx3>; Thu, 28 Feb 2002 20:53:29 -0500
Date: Thu, 28 Feb 2002 17:53:47 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Theodore Tso <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Dennis Jim <jdennis@snapserver.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Congrats Marcelo,
Message-ID: <20020301015347.GE2711@matchmail.com>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Dennis Jim <jdennis@snapserver.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0202281849450.2391-100000@freak.distro.conectiva> <E16gaUh-0001bB-00@the-village.bc.nu> <20020228202803.A14374@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020228202803.A14374@thunk.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2002 at 08:28:03PM -0500, Theodore Tso wrote:
> On Fri, Mar 01, 2002 at 12:01:51AM +0000, Alan Cox wrote:
> > > 
> > > Nope. I could well integrate lm_sensors in the future.
> > 
> > Please be careful. lm_sensors can destroy machines if configured wrongly.
> > Thats something that needs tackling - and ironically ACPI may actually
> > solve that problem
> 
> ... as in instant death for any modern Thinkpad laptops, requiring a
> trip back to the factory and a replacement of the motherboard...
> 
> *Please* don't integrate in lm_sensors without making sure the
> thinkpad killing feature has been fixed.
>

Or, just don't integrate that part of the patch...

