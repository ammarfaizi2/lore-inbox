Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286825AbSAQBDG>; Wed, 16 Jan 2002 20:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287488AbSAQBC4>; Wed, 16 Jan 2002 20:02:56 -0500
Received: from willow.seitz.com ([207.106.55.140]:50706 "EHLO willow.seitz.com")
	by vger.kernel.org with ESMTP id <S286825AbSAQBCo>;
	Wed, 16 Jan 2002 20:02:44 -0500
From: Ross Vandegrift <ross@willow.seitz.com>
Date: Wed, 16 Jan 2002 20:02:40 -0500
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.4 is available
Message-ID: <20020116200240.B22161@willow.seitz.com>
In-Reply-To: <20020116145605.A10792@thyrsus.com> <20020116175014.A21277@willow.seitz.com> <20020116174340.A16302@thyrsus.com> <20020116180042.A21447@willow.seitz.com> <20020116180112.C16592@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020116180112.C16592@thyrsus.com>; from esr@thyrsus.com on Wed, Jan 16, 2002 at 06:01:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > I've verified that the lockup I reported earlier still happens with 2.1.4.
> > > 
> > > Keystroke sequence to reproduce, please?
> > 
> > <ENTER>
> 
> On what screen?  With the tool invoked how?

Sorry, didn't mean to be so terse.  Same as before - 'make config' or 'make
menuconfig', press enter upon being shown the main menu while the default
selection is "Intel or Processor type (FROZEN)".

Ross Vandegrift
ross@willow.seitz.com
