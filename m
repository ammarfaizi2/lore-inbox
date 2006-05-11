Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbWEKQsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWEKQsQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 12:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbWEKQsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 12:48:16 -0400
Received: from palrel13.hp.com ([156.153.255.238]:29573 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S1030333AbWEKQsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 12:48:15 -0400
Message-ID: <44636ACB.4020705@hp.com>
Date: Thu, 11 May 2006 09:48:11 -0700
From: Rick Jones <rick.jones2@hp.com>
User-Agent: Mozilla/5.0 (X11; U; HP-UX 9000/785; en-US; rv:1.6) Gecko/20040304
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, tytso@mit.edu,
       Herbert Xu <herbert@gondor.apana.org.au>, xen-devel@lists.xensource.com,
       ian.pratt@xensource.com, rdreier@cisco.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       virtualization@lists.osdl.org, chrisw@sous-sol.org, shemminger@osdl.org
Subject: Re: [RFC PATCH 34/35] Add the Xen virtual network device driver.
References: <E1Fdz7v-0007zc-00@gondolin.me.apana.org.au>	<fb99d7085b85310ef7d423a8f135db32@cl.cam.ac.uk> <200605111147.53011.ak@suse.de>
In-Reply-To: <200605111147.53011.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From the peanut gallery...

Can remote TCP ISN's be considered a source of entropy these days?  How 
about checksums?

rick
