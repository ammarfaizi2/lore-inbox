Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271665AbRHUNe0>; Tue, 21 Aug 2001 09:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271660AbRHUNeQ>; Tue, 21 Aug 2001 09:34:16 -0400
Received: from [193.120.224.170] ([193.120.224.170]:8080 "EHLO florence.itg.ie")
	by vger.kernel.org with ESMTP id <S271661AbRHUNeK>;
	Tue, 21 Aug 2001 09:34:10 -0400
Date: Tue, 21 Aug 2001 14:34:16 +0100 (IST)
From: Paul Jakma <paulj@alphyra.ie>
To: David Schwartz <davids@webmaster.com>
cc: Paul Jakma <paul@clubi.ie>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] let Net Devices feed Entropy, updated (1/2)
In-Reply-To: <NOEJJDACGOHCKNCOGFOMAEGBDFAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.33.0108211425250.14271-100000@dunlop.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2001, David Schwartz wrote:

> appropriate ioctl function (RND_ADD_ENTROPY). Search drivers/chars/random.c

shame on me.

it appears the i810 RNG daemon does update the entropy count.

--paulj

