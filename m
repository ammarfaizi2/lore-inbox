Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbTHVQ4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 12:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbTHVQz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 12:55:59 -0400
Received: from rth.ninka.net ([216.101.162.244]:25217 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263962AbTHVQy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 12:54:59 -0400
Date: Fri, 22 Aug 2003 09:54:42 -0700
From: "David S. Miller" <davem@redhat.com>
To: Marcus Sundberg <marcus@ingate.com>
Cc: marcelo@conectiva.com.br, gzp@papp.hu, mostrows@speakeasy.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: PPPoE Oops with 2.4.22-rc
Message-Id: <20030822095442.5da08e24.davem@redhat.com>
In-Reply-To: <vezni16c62.fsf_-_@inigo.ingate.se>
References: <5ff3.3f388c4b.4453f@gzp1.gzp.hu>
	<Pine.LNX.4.44.0308121415540.10199-100000@logos.cnet>
	<39a.3f392c6f.86e8b@gzp1.gzp.hu>
	<vezni16c62.fsf_-_@inigo.ingate.se>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Aug 2003 15:43:01 +0200
Marcus Sundberg <marcus@ingate.com> wrote:

> this patch fixes one crash in pppoe_connect():

It's already in Marcelo's tree.
