Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263480AbRFMRUb>; Wed, 13 Jun 2001 13:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263473AbRFMRUV>; Wed, 13 Jun 2001 13:20:21 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:20488 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S263480AbRFMRUF>;
	Wed, 13 Jun 2001 13:20:05 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106131717.f5DHHRJ295569@saturn.cs.uml.edu>
Subject: Re: Going beyond 256 PCI buses
To: tom_gall@vnet.ibm.com (Tom Gall)
Date: Wed, 13 Jun 2001 13:17:27 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B273A20.8EE88F8F@vnet.ibm.com> from "Tom Gall" at Jun 13, 2001 05:02:08 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Gall writes:

>   I was wondering if there are any other folks out there like me who
> have the 256 PCI bus limit looking at them straight in the face?

I might. The need to reserve bus numbers for hot-plug looks like
a quick way to waste all 256 bus numbers.

> each PHB has an
> additional id, then each PHB can have up to 256 buses.

Try not to think of him as a PHB with an extra id. Lots of people
have weird collections. If your boss wants to collect buses, well,
that's his business. Mine likes boats. It's not a big deal, really.

(Did you not mean your pointy-haired boss has mental problems?)


