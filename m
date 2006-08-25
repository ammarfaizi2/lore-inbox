Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWHYXG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWHYXG3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 19:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWHYXG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 19:06:29 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:55943 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S964806AbWHYXG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 19:06:28 -0400
Date: Sat, 26 Aug 2006 01:06:26 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPV6 : segmentation offload not set correctly on TCP children
Message-ID: <20060825230626.GC4570@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Stephen Hemminger <shemminger@osdl.org>,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060821212243.GA1558@cip.informatik.uni-erlangen.de> <20060821150231.31a947d4@localhost.localdomain> <20060821222634.GC21790@cip.informatik.uni-erlangen.de> <20060825154353.3ecaf508@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825154353.3ecaf508@localhost.localdomain>
User-Agent: Mutt/1.5.11-2006-07-11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,
thanks for the fix, it fixes the problem for me. I closed the bug. On
which hardware did you reproduce the bug and how did you found it? Did
you use git bisect?

        Thomas
