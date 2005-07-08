Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262819AbVGHXmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbVGHXmK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 19:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbVGHXmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 19:42:05 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:15079 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262819AbVGHXk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 19:40:58 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: mbligh@mbligh.org, cw@f00f.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <20050708.162924.106265517.davem@davemloft.net>
References: <133660000.1120863575@flay>
	 <20050708230303.GA19188@taniwha.stupidest.org> <136640000.1120864499@flay>
	 <20050708.162924.106265517.davem@davemloft.net>
Content-Type: text/plain
Date: Fri, 08 Jul 2005 19:40:56 -0400
Message-Id: <1120866056.6488.43.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-08 at 16:29 -0700, David S. Miller wrote:
> From: "Martin J. Bligh" <mbligh@mbligh.org>
> Date: Fri, 08 Jul 2005 16:14:59 -0700
> 
> > I'm not saying there isn't data supporting higher HZ ... I just haven't
> > seen it published. I get the feeling what people really want is high-res
> > timers anyway ... high HZ is just concealing the issue and making it
> > slightly less crap, not actually fixing it.
> 
> We very much want sub-HZ timers, especially in the networking.

ALSA would also benefit greatly from this.

Lee

