Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277239AbRJDVtz>; Thu, 4 Oct 2001 17:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277241AbRJDVtf>; Thu, 4 Oct 2001 17:49:35 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:7571 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S277239AbRJDVta>; Thu, 4 Oct 2001 17:49:30 -0400
Date: Thu, 4 Oct 2001 17:49:45 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: mingo@elte.hu, jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>, netdev@oss.sgi.com,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <20011004174945.B18528@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0110031528370.6272-100000@localhost.localdomain> <302737894.1002234496@[195.224.237.69]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <302737894.1002234496@[195.224.237.69]>; from linux-kernel@alex.org.uk on Thu, Oct 04, 2001 at 10:28:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2001 at 10:28:17PM +0100, Alex Bligh - linux-kernel wrote:
> In at least one environment known to me (router), I'd rather it
> kept accepting packets, and f/w'ing them, and didn't switch VTs etc.
> By dropping down performance, you've made the DoS attack even
> more successful than it would otherwise have been (the kiddie
> looks at effect on the host at the end).

Then bug the driver author of your ethernet cards or turn the hammer off.  
You're the sysadmin, you know that your system is unusual.  Deal with it.

		-ben
