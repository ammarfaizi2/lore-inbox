Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWA0HSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWA0HSr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 02:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWA0HSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 02:18:47 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:2435 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S932337AbWA0HSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 02:18:46 -0500
Date: Fri, 27 Jan 2006 08:18:07 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, keyrings@linux-nfs.org
Subject: Re: [PATCH 00/04] Add DSA key type
Message-ID: <20060127071806.GA4082@hardeman.nu>
Mail-Followup-To: Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, dhowells@redhat.com,
	keyrings@linux-nfs.org
References: <1138312694656@2gen.com> <E1F2I7q-0007F6-00@gondolin.me.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <E1F2I7q-0007F6-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.5.11
X-SA-Score: -2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 12:10:06PM +1100, Herbert Xu wrote:
>David H?rdeman <david@2gen.com> wrote:
>>
>> crypto/mpi/Makefile               |   31 
>
>Wouldn't this make more sense under lib/mpi?

I have no problems with moving it to lib/mpi unless someone feels its a 
bad idea (DHowells, do you agree?).

Re,
David
