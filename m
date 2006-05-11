Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbWEKQzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbWEKQzx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 12:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWEKQzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 12:55:53 -0400
Received: from hera.kernel.org ([140.211.167.34]:47291 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030356AbWEKQzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 12:55:52 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [RFC PATCH 34/35] Add the Xen virtual network device driver.
Date: Thu, 11 May 2006 09:55:04 -0700
Organization: OSDL
Message-ID: <20060511095504.3107c05c@localhost.localdomain>
References: <E1Fdz7v-0007zc-00@gondolin.me.apana.org.au>
	<fb99d7085b85310ef7d423a8f135db32@cl.cam.ac.uk>
	<200605111147.53011.ak@suse.de>
	<44636ACB.4020705@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1147366503 15642 10.8.0.54 (11 May 2006 16:55:03 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Thu, 11 May 2006 16:55:03 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2006 09:48:11 -0700
Rick Jones <rick.jones2@hp.com> wrote:

>  From the peanut gallery...
> 
> Can remote TCP ISN's be considered a source of entropy these days?  How 
> about checksums?
> 
> rick

No, they are spoofable.
