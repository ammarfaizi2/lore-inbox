Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263188AbREWRyo>; Wed, 23 May 2001 13:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263190AbREWRye>; Wed, 23 May 2001 13:54:34 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:23033 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263188AbREWRyS>;
	Wed, 23 May 2001 13:54:18 -0400
Date: Wed, 23 May 2001 13:54:15 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: helgehaf@idb.hist.no, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct char_device
In-Reply-To: <UTC200105231334.PAA86145.aeb@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0105231351360.20269-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 May 2001 Andries.Brouwer@cwi.nl wrote:

> > But I don't want an initrd.
> 
> Don't be afraid of words. You wouldnt notice - it would do its
> job and disappear just like piggyback today.

Andries, initrd code is _sick_. Our boot sequence is not a wonder of
elegance, but that crap is the worst part. I certainly can understand
people not wanting to use that on aesthetical reasons alone.

