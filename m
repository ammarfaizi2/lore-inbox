Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUBLPNc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 10:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266489AbUBLPNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 10:13:32 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:19721 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S266486AbUBLPNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 10:13:31 -0500
Date: Thu, 12 Feb 2004 10:13:25 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: torvalds@osdl.org, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Shut up about the damn modules already...
In-Reply-To: <20040212031631.69CAD2C04B@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0402121013040.1068-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Feb 2004, Rusty Russell wrote:

> Just remove the debugging message which fill people's logs: the
> correct way of debugging module problems is something like this:

Could you add that to Documentation/  ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

