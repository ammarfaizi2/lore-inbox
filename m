Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273951AbRI0V7s>; Thu, 27 Sep 2001 17:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273952AbRI0V7i>; Thu, 27 Sep 2001 17:59:38 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:52488 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S273951AbRI0V7W>; Thu, 27 Sep 2001 17:59:22 -0400
Date: Thu, 27 Sep 2001 23:59:46 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Sean Swallow <sean@swallow.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD viper chipset and UDMA100
Message-ID: <20010927235946.B18423@suse.cz>
In-Reply-To: <Pine.LNX.4.33.0109271419430.32187-100000@lsd.nurk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0109271419430.32187-100000@lsd.nurk.org>; from sean@swallow.org on Thu, Sep 27, 2001 at 02:26:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2001 at 02:26:50PM -0700, Sean Swallow wrote:
> List,
> 
> I just got a tyan tiger w/ the AMD Viper chipset on it. For some reason
> Linux will only set the onboard (AMD viper) chains to UDMA33.
> 
> I'm using linux 2.4.9, and I have also tried 2.4.10. Is there a limitation
> to the AMD Viper driver?
> 
> PS. The cables (2) are BRAND new ata100 cables.

The Viper can do UDMA66 max. At least it's doing it for me quite well.

-- 
Vojtech Pavlik
SuSE Labs
