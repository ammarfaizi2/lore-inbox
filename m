Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277052AbRJDAsE>; Wed, 3 Oct 2001 20:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277054AbRJDAr7>; Wed, 3 Oct 2001 20:47:59 -0400
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:39439 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S277052AbRJDArt>; Wed, 3 Oct 2001 20:47:49 -0400
Date: Thu, 4 Oct 2001 01:48:18 +0100 (BST)
From: <chris@scary.beasts.org>
X-X-Sender: <cevans@sphinx.mythic-beasts.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.11pre2 - O_DIRECT code went missing?!
Message-ID: <Pine.LNX.4.33.0110040146540.29943-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Looks like the O_DIRECT flag was left in 2.4.11pre2, but most of the
O_DIRECT code was removed. Does this leave O_DIRECT non-functional? That
would be very confusing.

Cheers
Chris

