Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUFNIYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUFNIYY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 04:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbUFNIXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 04:23:31 -0400
Received: from holomorphy.com ([207.189.100.168]:61342 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262208AbUFNIWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 04:22:19 -0400
Date: Mon, 14 Jun 2004 01:21:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [1/12] don't dereference netdev->name before register_netdev()
Message-ID: <20040614082152.GG1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <40CD293D.4040808@pobox.com> <E1BZjzZ-0000D4-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BZjzZ-0000D4-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>> Herbert Xu has an updated patch for this, I'll compare both more closely...

On Mon, Jun 14, 2004 at 03:26:45PM +1000, Herbert Xu wrote:
> Please ignore the one posted in this thread.  It is hopelessly out
> of date.

Go with Herbert's, I'm basically shipping whatever I've seen from him,
and you've seen more recent and better.

Sorry about that Herbert, I appear to have dropped a number of packets
regarding the state of these things.


-- wli
