Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318765AbSHGMDL>; Wed, 7 Aug 2002 08:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318767AbSHGMDK>; Wed, 7 Aug 2002 08:03:10 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:43001 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318765AbSHGMDK>; Wed, 7 Aug 2002 08:03:10 -0400
Subject: Re: 64bit clean drivers was Re: Linux 2.4.20-pre1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020807135643.A9340@wotan.suse.de>
References: <20020807131813.A25485@wotan.suse.de>
	<200208071151.g77Bpmt19650@devserv.devel.redhat.com> 
	<20020807135643.A9340@wotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 14:26:17 +0100
Message-Id: <1028726777.18478.295.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-07 at 12:56, Andi Kleen wrote:
> Can you please shortly explain what will not be maintainable with my
> proposal? 

I already have - all the ifs and conditions in the Config.in files

If you think you can do it all nicely with dep_ and not if then prove me
wrong. I'd actually like to see a working clean implementation because I
agree about the problem, I'm dubious that the cure right now is better
than the disease

