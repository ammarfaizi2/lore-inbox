Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276627AbRJKRiH>; Thu, 11 Oct 2001 13:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276622AbRJKRh5>; Thu, 11 Oct 2001 13:37:57 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:26356 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S276627AbRJKRhw>; Thu, 11 Oct 2001 13:37:52 -0400
Date: Thu, 11 Oct 2001 10:35:40 -0700
From: Chris Wright <chris@wirex.com>
To: Malcolm Mallardi <magamo@mirkwood.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.12 Compiling error.
Message-ID: <20011011103540.A21678@figure1.int.wirex.com>
Mail-Followup-To: Malcolm Mallardi <magamo@mirkwood.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011011132003.A13730@trianna.upcommand.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011011132003.A13730@trianna.upcommand.net>; from magamo@mirkwood.net on Thu, Oct 11, 2001 at 01:20:03PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Malcolm Mallardi (magamo@mirkwood.net) wrote:
> In the new Kernel 2.4.12, when attempting to compile modules, the parport 
> module dies, I'm attempting to compile it with IEEE1284 readback support 

this is known.  check archives.  patch is here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=100278983703821&w=2

-chris
