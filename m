Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286222AbSAAG7l>; Tue, 1 Jan 2002 01:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287767AbSAAG7b>; Tue, 1 Jan 2002 01:59:31 -0500
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:41224 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S286222AbSAAG7Z>;
	Tue, 1 Jan 2002 01:59:25 -0500
Subject: Re: Dual athlon XP 1800 problems
From: Shaya Potter <spotter@opus.cs.columbia.edu>
To: Dave Jones <davej@suse.de>
Cc: ccroswhite@get2chip.com, Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020101032335.A11129@suse.de>
In-Reply-To: <3C311B00.FFB58648@get2chip.com> 
	<20020101032335.A11129@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 01 Jan 2002 01:58:23 -0500
Message-Id: <1009868304.27412.2.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I missed the original message, I'm running a dual athlon 1800+ XP system
(actually both CPU for some reason get identified as MPs, but they are
retail XP chips).

I assume you are using a tyan tiger or thunder motherboard (as I dont
know of any others in retail yet).  Is your ram registered ecc ram?  If
it's not, that most likely is your problem.

Is your ram from tyan's approved list?  Mine isn't (crucial, but I have
never had bad luck with them, even though others seem to have had some
problems), but I would see if it would change if you would get ram from
suppliers tyan reccomends.

On the issue of future motherboards not supporting XPs at all, I've read
in multiple places that the rumor to that effect was false, and that the
motherboards will not lock out XPs, they just won't be supported (much
like motherboard manufacturers don't support overclocking, but many give
you the means to do it).  If you have information direct from the
manufacturers, than I have no reason to not believe you.

On Mon, 2001-12-31 at 22:23, Dave Jones wrote:
> On Mon, Dec 31, 2001 at 06:12:16PM -0800, ccroswhite@get2chip.com wrote:
>  > I am having problems with dual athlons and more than 512M RAM.
>  > Here is the configuration:
>  > Dual Athlon XP 1800
>                ^^
>  Not a valid SMP configuration. Some people are getting away with
>  running XP's in SMP boxes, others aren't. And soon, it looks like
>  no new XP's will run in SMP at all.
> 
>  Take one out/boot a UP kernel, and see if the problems go away.
> 
>  Dave.
> 
> -- 
> Dave Jones.                    http://www.codemonkey.org.uk
> SuSE Labs.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


