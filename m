Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbSJWQ2W>; Wed, 23 Oct 2002 12:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbSJWQ2W>; Wed, 23 Oct 2002 12:28:22 -0400
Received: from sentry.gw.tislabs.com ([192.94.214.100]:47332 "EHLO
	sentry.gw.tislabs.com") by vger.kernel.org with ESMTP
	id <S262780AbSJWQ2V>; Wed, 23 Oct 2002 12:28:21 -0400
Date: Wed, 23 Oct 2002 12:34:05 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
X-X-Sender: <sds@raven>
To: Christoph Hellwig <hch@infradead.org>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
       Russell Coker <russell@coker.com.au>, <linux-kernel@vger.kernel.org>,
       <linux-security-module@wirex.com>
Subject: Re: [PATCH] remove sys_security
In-Reply-To: <20021023172407.A14270@infradead.org>
Message-ID: <Pine.GSO.4.33.0210231231470.7042-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Oct 2002, Christoph Hellwig wrote:

> extended attributes are both in 2.4.20-pre and 2.5 (for a long time).

I meant the merging of the EA implementations for ext[23], not just the
EA API calls.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



