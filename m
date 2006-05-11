Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbWEKRac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbWEKRac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 13:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbWEKRac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 13:30:32 -0400
Received: from ns.suse.de ([195.135.220.2]:38337 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030387AbWEKRab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 13:30:31 -0400
From: Andi Kleen <ak@suse.de>
To: Rick Jones <rick.jones2@hp.com>
Subject: Re: [RFC PATCH 34/35] Add the Xen virtual network device driver.
Date: Thu, 11 May 2006 19:30:20 +0200
User-Agent: KMail/1.9.1
Cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, tytso@mit.edu,
       Herbert Xu <herbert@gondor.apana.org.au>, xen-devel@lists.xensource.com,
       ian.pratt@xensource.com, rdreier@cisco.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       virtualization@lists.osdl.org, chrisw@sous-sol.org, shemminger@osdl.org
References: <E1Fdz7v-0007zc-00@gondolin.me.apana.org.au> <200605111147.53011.ak@suse.de> <44636ACB.4020705@hp.com>
In-Reply-To: <44636ACB.4020705@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605111930.20852.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 May 2006 18:48, Rick Jones wrote:
>  From the peanut gallery...
> 
> Can remote TCP ISN's be considered a source of entropy these days?  How 
> about checksums?

Indirectly - we measure how long it takes to compute them.

-Andi
