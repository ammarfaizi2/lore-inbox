Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281319AbRKEUlW>; Mon, 5 Nov 2001 15:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281318AbRKEUlM>; Mon, 5 Nov 2001 15:41:12 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:16144 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S281336AbRKEUk5>; Mon, 5 Nov 2001 15:40:57 -0500
Date: Fri, 2 Nov 2001 12:13:12 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: 2xQ: Is PM + ACPI but /no/ APM a valid configuration? Interru		pts enabled in APM set power state?
Message-ID: <20011102121311.A35@toy.ucw.cz>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D6DC@orsmsx111.jf.intel.com> <284303687.1004565440@[195.224.237.69]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <284303687.1004565440@[195.224.237.69]>; from linux-kernel@alex.org.uk on Wed, Oct 31, 2001 at 09:57:21PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> PM, ACPI, no APM
> 
> Suspend buttons (all of them) & closing laptop
> lid no longer do anything. As there's no apm support,
> apm -s doesn't work either, so impossible to test
> suspend.
> 
> [wierd messages now gone - thanks Andrew.].

That means that ACPI works as expected. Good.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

