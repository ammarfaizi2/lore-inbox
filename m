Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316906AbSF0SfA>; Thu, 27 Jun 2002 14:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316909AbSF0Se7>; Thu, 27 Jun 2002 14:34:59 -0400
Received: from web30.achilles.net ([209.151.1.2]:63115 "EHLO
	web30.achilles.net") by vger.kernel.org with ESMTP
	id <S316906AbSF0Se7>; Thu, 27 Jun 2002 14:34:59 -0400
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
From: Robert Love <rml@tech9.net>
To: "Alexandre P. Nunes" <alex@PolesApart.dhs.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D1B5982.60008@PolesApart.dhs.org>
References: <Pine.LNX.4.44.0206222202400.7601-100000@PolesApart.dhs.org>
	<20020626204721.GK22961@holomorphy.com>
	<1025125214.1911.40.camel@localhost.localdomain>
	<1025128477.1144.3.camel@icbm> <20020627005431.GM22961@holomorphy.com>
	<1025192465.1084.3.camel@icbm> <20020627154712.GO22961@holomorphy.com> 
	<3D1B5982.60008@PolesApart.dhs.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 Jun 2002 14:31:54 -0400
Message-Id: <1025202738.1084.12.camel@icbm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-06-27 at 14:29, Alexandre P. Nunes wrote:

> The user (oops, that is me) was using 
> preempt-kernel-rml-2.4.19-pre10-ac2-1, by the time of the report.

Ah try preempt-kernel-rml-2.4.19-pre10-ac2-2 which has the bit lock
safing William mentioned.

	Robert Love

