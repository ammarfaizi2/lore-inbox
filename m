Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265506AbSKSOUc>; Tue, 19 Nov 2002 09:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265513AbSKSOUb>; Tue, 19 Nov 2002 09:20:31 -0500
Received: from poup.poupinou.org ([195.101.94.96]:53543 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S265506AbSKSOUa>; Tue, 19 Nov 2002 09:20:30 -0500
Date: Tue, 19 Nov 2002 15:27:31 +0100
To: Dave Jones <davej@codemonkey.org.uk>,
       Margit Schubert-While <margit@margit.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20 ACPI
Message-ID: <20021119142731.GF27595@poup.poupinou.org>
References: <4.3.2.7.2.20021119134830.00b53680@mail.dns-host.com> <20021119130728.GA28759@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021119130728.GA28759@suse.de>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Tue, Nov 19, 2002 at 01:07:28PM +0000, Dave Jones wrote:
> On Tue, Nov 19, 2002 at 01:53:15PM +0100, Margit Schubert-While wrote:
>  > 	Any chance to get an ACPI update into 2.4.20 ?
> 
> Now that we're in 2.4.20rc stage ? No chance.
> 
>  > 	It doesn't like my Intel D845PESV.
>  
> The newer ACPI code also introduces problems that aren't
> present with the current 2.4.20rc code.

I disagree with you.  It introduces more enhancements,
and more bugfix than the current code.  I admit that tt
could introduce some news bugs, but in the balance it
should be more stable than before.
Really, I will be happy to see new code in mainstream.

> Eg: Last snapshot I tried, My Vaio wouldn't boot if it was
> running on battery (which is the time I'd need it most).

What is actually the trouble with your Vaio (I mean dmesg when
it failed) ?  I saw some (old) Vaio where new code worked
like a charm (even speedstep worked, but it's another
story ;)

I would be happy also to take a look to the DSDT table of your model.

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
