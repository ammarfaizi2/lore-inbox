Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317880AbSGPQZc>; Tue, 16 Jul 2002 12:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317882AbSGPQZb>; Tue, 16 Jul 2002 12:25:31 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:9971 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317880AbSGPQZb>; Tue, 16 Jul 2002 12:25:31 -0400
Subject: Re: sched.h problem
From: Robert Love <rml@tech9.net>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020716063757.GB21792@louise.pinerecords.com>
References: <20020716063757.GB21792@louise.pinerecords.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Jul 2002 09:28:21 -0700
Message-Id: <1026836902.1142.145.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-15 at 23:37, Tomas Szepe wrote:
 
> I'm trying to get -ac to compile on sparc32 again.

2.4-ac only works on a few architectures (x86 and Alpha) due to the O(1)
scheduler changes...

	Robert Love

