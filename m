Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317577AbSGJRvl>; Wed, 10 Jul 2002 13:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317578AbSGJRvk>; Wed, 10 Jul 2002 13:51:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63732 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317577AbSGJRvj>; Wed, 10 Jul 2002 13:51:39 -0400
Subject: Re: [STATUS 2.5]  July 10, 2002
From: Robert Love <rml@tech9.net>
To: Guillaume Boissiere <boissiere@adiglobal.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D2B89AC.25661.91896FEB@localhost>
References: <3D2B89AC.25661.91896FEB@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Jul 2002 10:54:21 -0700
Message-Id: <1026323661.1178.73.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-09 at 22:11, Guillaume Boissiere wrote:

> As usual, feedback welcome!

As of 2.5.25, we have HZ=1000 (on x86) and a scalable user-space
exported clock_t that remains at 100 HZ to keep user-space compatible. 
This is attributed to the Commander in Chief, Linus Torvalds.

	Robert Love

