Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSFTIQk>; Thu, 20 Jun 2002 04:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312254AbSFTIQj>; Thu, 20 Jun 2002 04:16:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54021 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S311898AbSFTIQi>; Thu, 20 Jun 2002 04:16:38 -0400
Date: Thu, 20 Jun 2002 09:16:37 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: rml@tech9.net, george@mvista.com, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace timer_bh with tasklet
Message-ID: <20020620091637.C6313@flint.arm.linux.org.uk>
References: <1024538005.922.70.camel@sinai> <20020619.185514.52961715.davem@redhat.com> <20020620091115.A6313@flint.arm.linux.org.uk> <20020620.010907.120151704.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020620.010907.120151704.davem@redhat.com>; from davem@redhat.com on Thu, Jun 20, 2002 at 01:09:07AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 01:09:07AM -0700, David S. Miller wrote:
>    You appear to have missed willy's posting a couple of days ago
>    fixing up the serial driver BHs.
> 
> Did it get applied to 2.5.x?

I have no idea - I've not looked at what Linus has put into the kernel
after 2.5.21 yet.  Too busy I'm afraid.  However, the patch has been
aired on lkml and didn't receive any negative feedback.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

