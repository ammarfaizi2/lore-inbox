Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131201AbRCKC1f>; Sat, 10 Mar 2001 21:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131204AbRCKC1P>; Sat, 10 Mar 2001 21:27:15 -0500
Received: from [216.161.55.93] ([216.161.55.93]:29169 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S131201AbRCKC1F>;
	Sat, 10 Mar 2001 21:27:05 -0500
Date: Sat, 10 Mar 2001 18:30:20 -0800
From: Greg KH <greg@kroah.com>
To: David Huggins-Daines <dhd@eradicator.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12 and ac13 breaks usb-visor
Message-ID: <20010310183020.A11479@wirex.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	David Huggins-Daines <dhd@eradicator.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E14aQA9-0001br-00@the-village.bc.nu> <20010307172056.A8647@austin.rr.com> <20010307173640.A14818@kroah.com> <20010308140103.A17993@austin.rr.com> <20010308160758.A16296@kroah.com> <20010309141332.A29339@austin.rr.com> <20010309133112.A17792@kroah.com> <871ys6xtk7.fsf@monolith.eradicator.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <871ys6xtk7.fsf@monolith.eradicator.org>; from dhd@eradicator.org on Fri, Mar 09, 2001 at 09:10:32PM -0500
X-Operating-System: Linux 2.4.2-ac14 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2001 at 09:10:32PM -0500, David Huggins-Daines wrote:
> It's the one listed in arch/i386/defconfig.  Of course, it's debatable
> whether that actually means 'default' or not (since in fact it's more
> like 'what Linus uses'), but plenty of people will see it as such.

Thanks for pointing that out to me, I think it's time for a
documentation patch :)

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
