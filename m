Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313201AbSE2C5F>; Tue, 28 May 2002 22:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSE2C5E>; Tue, 28 May 2002 22:57:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38894 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S313201AbSE2C5D>; Tue, 28 May 2002 22:57:03 -0400
Subject: Re: [PATCH] updated O(1) scheduler for 2.4
From: Robert Love <rml@mvista.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020524160223.GA1761@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 May 2002 19:57:00 -0700
Message-Id: <1022641021.23427.329.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-05-24 at 09:02, J.A. Magallon wrote:

> I had to make this to get it built:
> <snip>

Thanks, I have put these changes into the 2.4.19-pre9 version of the
patch which is available at:

	http://www.kernel.org/pub/linux/kernel/people/rml/sched/ingo-O1/sched-O1-rml-2.4.19-pre9-1.patch

Hopefully Alan will put out a 2.4.19-pre9-ac1 with the last of the bits
I pushed him.

	Robert Love

