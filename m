Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbUJZXxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbUJZXxc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 19:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbUJZXxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 19:53:32 -0400
Received: from gate.crashing.org ([63.228.1.57]:20961 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261547AbUJZXxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 19:53:23 -0400
Subject: Re: [PATCH] ppc64: Fix g5-only build
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Rose <johnrose@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
In-Reply-To: <1098808895.32293.23.camel@sinatra.austin.ibm.com>
References: <1098775712.6897.17.camel@gaston>
	 <1098808895.32293.23.camel@sinatra.austin.ibm.com>
Content-Type: text/plain
Date: Wed, 27 Oct 2004 09:49:43 +1000
Message-Id: <1098834583.6898.64.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-26 at 11:41 -0500, John Rose wrote:
> Forgive me for the cross-post, but I'm trying to answer two list
> messages on the same topic.  I think it's more productive to just fix
> the bug than to commit a giant comment pointing out a small bug, so I've
> attached an alternate fix (build tested for g5 :).

I replied the other list, let's stop this thread here.

Ben.

