Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291212AbSBGS12>; Thu, 7 Feb 2002 13:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291197AbSBGS1X>; Thu, 7 Feb 2002 13:27:23 -0500
Received: from barbados.bluemug.com ([63.195.182.101]:46344 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S291194AbSBGS1E>; Thu, 7 Feb 2002 13:27:04 -0500
Date: Thu, 7 Feb 2002 10:26:53 -0800
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020207182653.GA26664@bluemug.com>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <a3mjhc$qba$1@cesium.transmeta.com> <E16YOBB-0002Mx-00@starship.berlin> <20020207041356.GA21694@bluemug.com> <E16YoRQ-0000aS-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16YoRQ-0000aS-00@starship.berlin>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 02:18:20PM +0100, Daniel Phillips wrote:
> On February 7, 2002 05:13 am, Mike Touloumtzis wrote:
> > 
> > The kernel is just a program, and this is a tools problem.  You don't
> > see people arguing that cat's documentation should be moved into /bin/cat
> > in case administrators misplace "cat.1.gz".
> 
> Cat is standard, kernels aren't.  When was the last time you installed a
> custom cat?

I installed a custom rsync just the other day, and I did it by downloading
the Debian rsync source, patching it, and building a Debian package.
I would certainly do the same for cat if I needed to.

Sorry, I still don't see any fundamental difference.

miket
