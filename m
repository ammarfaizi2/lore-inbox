Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbTFLRPh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 13:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264918AbTFLRPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 13:15:37 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:50870 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S264916AbTFLRPf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 13:15:35 -0400
Subject: Re: 2.5.70-mm8: freeze after starting X
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
       piggin@cyberone.com.au
In-Reply-To: <1055438377.1058.2.camel@serpentine.internal.keyresearch.com>
References: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>
	 <20030611154122.55570de0.akpm@digeo.com> <1055374476.673.1.camel@localhost>
	 <1055377120.665.6.camel@localhost> <20030611172444.76556d5d.akpm@digeo.com>
	 <1055438377.1058.2.camel@serpentine.internal.keyresearch.com>
Content-Type: text/plain
Message-Id: <1055438960.1043.0.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 12 Jun 2003 10:29:20 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 10:19, Bryan O'Sullivan wrote:

> I'm about to try, um, whichever of the umpty-ump patches that went back
> and forth looks most plausible.

Tried your two-liner, Andrew, but -mm8 is as freezy as ever.  I'll see
if I can hook up a serial console and find an oops at some point.

	<b

