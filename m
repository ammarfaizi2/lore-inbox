Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317462AbSGTSdt>; Sat, 20 Jul 2002 14:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317463AbSGTSdt>; Sat, 20 Jul 2002 14:33:49 -0400
Received: from quattro-eth.sventech.com ([205.252.89.20]:7940 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S317462AbSGTSds>; Sat, 20 Jul 2002 14:33:48 -0400
Date: Sat, 20 Jul 2002 14:36:53 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Craig Kulesa <ckulesa@as.arizona.edu>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [USB] uhci-hcd oops on APM resume (2.5.23-26)
Message-ID: <20020720143653.B23737@sventech.com>
References: <20020719194326.GA23137@kroah.com> <Pine.LNX.4.44.0207192306030.5859-100000@loke.as.arizona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207192306030.5859-100000@loke.as.arizona.edu>; from ckulesa@as.arizona.edu on Fri, Jul 19, 2002 at 11:18:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2002, Craig Kulesa <ckulesa@as.arizona.edu> wrote:
> Excellent.  The patch from Jan Harkes that you posted 
> (http://www.cs.helsinki.fi/linux/linux-kernel/2002-28/1463.html)
> worked wonderfully for me.  No more rogue USB disconnects on APM resume, 
> and no more oopses. 
> 
> Any hopes for sending it Linus-ward? ;)

FWIW Greg, this patch is correct. Thanks!

JE

