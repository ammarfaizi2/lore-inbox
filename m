Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267521AbSLEWLX>; Thu, 5 Dec 2002 17:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267524AbSLEWLX>; Thu, 5 Dec 2002 17:11:23 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:33926 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S267521AbSLEWLW>;
	Thu, 5 Dec 2002 17:11:22 -0500
Subject: Re: hidden interface (ARP) 2.4.20
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: "David S. Miller" <davem@redhat.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <1039124530.18881.0.camel@rth.ninka.net>
References: <A6B0BFA3B496A24488661CC25B9A0EFA333DEF@himl07.hickam.pacaf.ds.af.mil> 
	<1039124530.18881.0.camel@rth.ninka.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 05 Dec 2002 23:18:48 +0100
Message-Id: <1039126728.30495.55.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-05 at 22:42, David S. Miller wrote:
> On Thu, 2002-12-05 at 12:53, Bingner Sam J Contractor PACAF CSS/SCHE
> wrote:
> > Attached is a patch that seems to work for the hidden flag in 2.4.20... for
> > anybody else who needs this functionality
> 
> Use the ARP filter netfilter module or the routing based solutions
> instead, please.

How does one use the arpfilter module? Any pointers to userspace
utilities? 

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat
you with experience.
