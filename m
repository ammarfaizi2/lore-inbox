Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278076AbRJZJ2L>; Fri, 26 Oct 2001 05:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278078AbRJZJ2A>; Fri, 26 Oct 2001 05:28:00 -0400
Received: from theirongiant.weebeastie.net ([203.62.148.50]:61828 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S278076AbRJZJ1w>; Fri, 26 Oct 2001 05:27:52 -0400
Date: Fri, 26 Oct 2001 19:27:50 +1000
From: CaT <cat@zip.com.au>
To: Pavel Machek <pavel@suse.cz>
Cc: Marcos Dione <mdione@hal.famaf.unc.edu.ar>, linux-kernel@vger.kernel.org
Subject: Re: kjournald and disk sleeping
Message-ID: <20011026192750.A670@zip.com.au>
In-Reply-To: <Pine.LNX.4.30.0110221415460.19985-100000@multivac.famaf.unc.edu.ar> <20011025161330.A38@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011025161330.A38@toy.ucw.cz>
User-Agent: Mutt/1.3.23i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 04:13:31PM +0000, Pavel Machek wrote:
> Hi!
> 
> > 	One thing I thought: how is this supposed to work on laptops? can
> > they be suspended? a question related to this one: I also have ACPI turned
> > on and APM turned off. how can I switch to stanby states? is there a way?
> > again, how does it works on laptops?
> 
> I'm working on suspend-to-disk, and suspend-to-ram is mostly working, also.
> ...

Sweet.

What's not working with suspend-to-ram? Gateway, in their infinate
wisdon, nuked suspend-to-disk functionality of the bios in the most
recent edition (which they kindly upgraded me to when I put my laptop
in for servicing...). As such I only have suspend-to-ram working and
I'm also interested in playing with ACPI.

-- 
CaT        "As you can expect it's really affecting my sex life. I can't help
           it. Each time my wife initiates sex, these ejaculating hippos keep
           floating through my mind."
                - Mohd. Binatang bin Goncang, Singapore Zoological Gardens
