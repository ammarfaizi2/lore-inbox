Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288153AbSBGWOR>; Thu, 7 Feb 2002 17:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291386AbSBGWOD>; Thu, 7 Feb 2002 17:14:03 -0500
Received: from barbados.bluemug.com ([63.195.182.101]:25866 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S288153AbSBGWNm>; Thu, 7 Feb 2002 17:13:42 -0500
Date: Thu, 7 Feb 2002 14:13:36 -0800
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020207221336.GD27645@bluemug.com>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <a3mjhc$qba$1@cesium.transmeta.com> <E16Yvmf-00015n-00@starship.berlin> <20020207214145.GA27645@bluemug.com> <E16Ywj7-00016Y-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16Ywj7-00016Y-00@starship.berlin>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 11:09:09PM +0100, Daniel Phillips wrote:
> On February 7, 2002 10:41 pm, Mike Touloumtzis wrote:
> > Adding configuration information to the kernel is a change to the status
> > quo, and has a cost.  The cost is small, but I'm unsympathetic to that
> > argument because many small convenience features, each with a small cost,
> > add up to a large cost.
> 
> The cost is *zero* if you don't enable the option, is this concept difficult
> for you?

That argument can be used to justify almost anything.  But it's not
zero maintenance cost or code complexity cost.  No one wants the kernel
to be an unmaintainable nest of CONFIG_FOO and #ifdef BAR because of
"zero cost" options.

miket
