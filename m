Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264942AbRG0VrI>; Fri, 27 Jul 2001 17:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265101AbRG0Vq6>; Fri, 27 Jul 2001 17:46:58 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:43271 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264942AbRG0Vqr>; Fri, 27 Jul 2001 17:46:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: bvermeul@devel.blackstar.nl, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Date: Fri, 27 Jul 2001 23:49:02 +0200
X-Mailer: KMail [version 1.2]
Cc: Hans Reiser <reiser@namesys.com>, kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0107272037380.16051-100000@devel.blackstar.nl>
In-Reply-To: <Pine.LNX.4.33.0107272037380.16051-100000@devel.blackstar.nl>
MIME-Version: 1.0
Message-Id: <0107272349020U.00285@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Friday 27 July 2001 20:47, bvermeul@devel.blackstar.nl wrote:
> I don't mind loosing data I've just written, but I
> *hate* it when it garbles all my files.

Have you tried running with no tail merging?  (And no already-merged 
tails.)

--
Daniel
