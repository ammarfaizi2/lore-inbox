Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291122AbSBGWXR>; Thu, 7 Feb 2002 17:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291373AbSBGWXH>; Thu, 7 Feb 2002 17:23:07 -0500
Received: from dsl-213-023-038-235.arcor-ip.net ([213.23.38.235]:41106 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291122AbSBGWW7>;
	Thu, 7 Feb 2002 17:22:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Mike Touloumtzis <miket@bluemug.com>
Subject: Re: How to check the kernel compile options ?
Date: Thu, 7 Feb 2002 23:27:14 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
In-Reply-To: <a3mjhc$qba$1@cesium.transmeta.com> <E16Ywj7-00016Y-00@starship.berlin> <20020207221336.GD27645@bluemug.com>
In-Reply-To: <20020207221336.GD27645@bluemug.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Yx0d-00016d-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 7, 2002 11:13 pm, Mike Touloumtzis wrote:
> On Thu, Feb 07, 2002 at 11:09:09PM +0100, Daniel Phillips wrote:
> > On February 7, 2002 10:41 pm, Mike Touloumtzis wrote:
> > > Adding configuration information to the kernel is a change to the status
> > > quo, and has a cost.  The cost is small, but I'm unsympathetic to that
> > > argument because many small convenience features, each with a small cost,
> > > add up to a large cost.
> > 
> > The cost is *zero* if you don't enable the option, is this concept difficult
> > for you?
> 
> That argument can be used to justify almost anything.  But it's not
> zero maintenance cost or code complexity cost.  No one wants the kernel
> to be an unmaintainable nest of CONFIG_FOO and #ifdef BAR because of
> "zero cost" options.

OK, there we are, your real argument: you think adding this option will make
the kernel unmaintainable.

feh.

-- 
Daniel
