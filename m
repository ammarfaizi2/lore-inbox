Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbRFQIWf>; Sun, 17 Jun 2001 04:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264700AbRFQIWZ>; Sun, 17 Jun 2001 04:22:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:13008 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264699AbRFQIWO>;
	Sun, 17 Jun 2001 04:22:14 -0400
Date: Sun, 17 Jun 2001 04:21:42 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "SATHISH.J" <sathish.j@tatainfotech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Reg:use of file_system_type structure
In-Reply-To: <Pine.LNX.4.10.10106171348580.11158-100000@blrmail>
Message-ID: <Pine.GSO.4.21.0106170410170.13857-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Jun 2001, SATHISH.J wrote:

> Hi,
> Every file system has file_system_type structure defined. Where else this
> structure is referred. Does register_filesystem() refer this structure.
> Does sys_mount refer to this structure by any means?

Umm... No offense, but
	* all of these questions take a couple of minutes to answer.
	* if you know how to use grep you should be able to find the
answer faster than anybody could reply
	* if you know C the last two questions are non-issue (everyone who
doubts that is welcome to read the register_filesystem() source and see
what arguments do its callers pass to it)
	* it looks suspiciously similar to, pardon me, attempt to cheat on
a quiz.

