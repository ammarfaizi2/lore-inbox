Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267487AbTBUPA7>; Fri, 21 Feb 2003 10:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267488AbTBUPA7>; Fri, 21 Feb 2003 10:00:59 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:26812 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S267487AbTBUPAg>; Fri, 21 Feb 2003 10:00:36 -0500
Date: Fri, 21 Feb 2003 10:10:38 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.x, 2.4.x ...] very small
Message-ID: <20030221151038.GA1224@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030221144448Z267481-29901+571@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221144448Z267481-29901+571@vger.kernel.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 03:25:17PM +0100, javaman wrote:
> A very small patch (my first patch :-) for Documentation/spinlocks.txt:
> it replace "IFF" with "IF" ;-)
> 
> bye,
> Paolo
> 
> --- Documentation/spinlocks.txt.orig	Fri Feb 21 15:02:01 2003
> +++ Documentation/spinlocks.txt	Fri Feb 21 15:02:44 2003
> @@ -136,7 +136,7 @@
>  
>  If you have a case where you have to protect a data structure across
>  several CPU's and you want to use spinlocks you can potentially use
> -cheaper versions of the spinlocks. IFF you know that the spinlocks are
> +cheaper versions of the spinlocks. IF you know that the spinlocks are
>  never used in interrupt handlers, you can use the non-irq versions:
>  
>  	spin_lock(&lock);
> 

IFF is usually an abbreviation for "If and only if", not a typo.

-- 
Murray J. Root

