Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRAVIya>; Mon, 22 Jan 2001 03:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129846AbRAVIyU>; Mon, 22 Jan 2001 03:54:20 -0500
Received: from [195.92.70.201] ([195.92.70.201]:16388 "EHLO
	blacklight.gweep.org.uk") by vger.kernel.org with ESMTP
	id <S129532AbRAVIyG>; Mon, 22 Jan 2001 03:54:06 -0500
Date: Mon, 22 Jan 2001 08:54:18 +0000
From: Howard Johnson <merlin@mwob.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: "John O'Donnell" <johnod@voicefx.com>,
        Matthew Fredrickson <lists@frednet.dyndns.org>,
        linux-kernel@vger.kernel.org
Subject: Re: VIA chipset discussion
Message-ID: <20010122085418.A11886@mwob.org.uk>
In-Reply-To: <Pine.LNX.4.21.0101171358020.1171-100000@ns-01.hislinuxbox.com> <20010118020408.A4713@iname.com> <20010118121356.A28529@frednet.dyndns.org> <3A677D17.8000701@voicefx.com> <20010118234225.A7210@www.mwob.org.uk> <20010119155333.A2050@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010119155333.A2050@suse.cz>; from vojtech@suse.cz on Fri, Jan 19, 2001 at 03:53:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2001 at 03:53:33PM +0100, Vojtech Pavlik wrote:
> On Thu, Jan 18, 2001 at 11:42:25PM +0000, Howard Johnson wrote:
> > On Thu, Jan 18, 2001 at 06:32:39PM -0500, John O'Donnell wrote:
> > > Matthew Fredrickson wrote:
> 
> My bet is ACPI/powermanagement messing with it ...

Ah, APM. So often blamed. So often the cause. ;-)

Yep, pulling APM support out of my kernel seems to have fixed the problem. I'll
start playing with APM settings, then.

Cheers.

-- 
Howard Johnson
merlin@mwob.org.uk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
