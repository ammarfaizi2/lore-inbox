Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292021AbSBOAWx>; Thu, 14 Feb 2002 19:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292030AbSBOAWn>; Thu, 14 Feb 2002 19:22:43 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:39940 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S292027AbSBOAWc>; Thu, 14 Feb 2002 19:22:32 -0500
Date: Fri, 15 Feb 2002 01:22:26 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Hal Duston <hald@sound.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Input w/2.5.3-dj3
Message-ID: <20020215012226.A3747@suse.cz>
In-Reply-To: <Pine.GSO.4.10.10202141319410.19668-100000@sound.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.10.10202141319410.19668-100000@sound.net>; from hald@sound.net on Thu, Feb 14, 2002 at 01:24:36PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2002 at 01:24:36PM -0600, Hal Duston wrote:

> Sorry I haven't gotten back to you before this, but life got in the way.
> 
> OK, I've got the timeouts bumped up as you suggested earlier, and applied 
> the patch from the 12th.  Both of these things together w/o any options
> make the keyboard work again.
> 
> Yes, this _is_ a weird machine.  It's a laptop that is a true PS/2 (MCA
> bus) from 1994.  All the rest of the hardware is "odd" as well, so why not
> the keyboard?
> 
> If you want me to look at anything else, let me know.

Thanks for the report. Since the changes don't affect other hardware and
are quite correct as well, future versions will keep them, and will work
on weird hardware like yours.

-- 
Vojtech Pavlik
SuSE Labs
