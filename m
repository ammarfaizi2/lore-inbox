Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWFSUuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWFSUuj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWFSUuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:50:39 -0400
Received: from cantor2.suse.de ([195.135.220.15]:18869 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932097AbWFSUui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:50:38 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC 0/4] Object reclaim via the slab allocator V1
Date: Mon, 19 Jun 2006 22:50:29 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>,
       Marcelo Tosatti <marcelo@kvack.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Theodore Tso <tytso@mit.edu>,
       Dave Chinner <dgc@sgi.com>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606192250.30428.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 June 2006 20:46, Christoph Lameter wrote:
> We currently have a set of problem with slab reclaim:

[...] Very cool. We discussed something like that forever but
it's great that finally someone implements it.

-Andi
