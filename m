Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274255AbRJNFIF>; Sun, 14 Oct 2001 01:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274298AbRJNFHz>; Sun, 14 Oct 2001 01:07:55 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:46045 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274255AbRJNFHt>;
	Sun, 14 Oct 2001 01:07:49 -0400
Date: Sun, 14 Oct 2001 01:08:21 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ed Tomlinson <tomlins@CAM.ORG>
cc: linux-kernel@vger.kernel.org
Subject: Re: mount hanging 2.4.12
In-Reply-To: <20011014034101.1955DB623@oscar.casa.dyndns.org>
Message-ID: <Pine.GSO.4.21.0110140103210.3903-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Deadlocks on lock_super().  I don't see any changes in that
area, though...

