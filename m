Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317426AbSGXR0u>; Wed, 24 Jul 2002 13:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317427AbSGXR0u>; Wed, 24 Jul 2002 13:26:50 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:13542 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317426AbSGXR0t>;
	Wed, 24 Jul 2002 13:26:49 -0400
Date: Wed, 24 Jul 2002 13:30:01 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jens Axboe <axboe@suse.de>
cc: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
Subject: Re: DAC960 Bitrot
In-Reply-To: <20020724170227.GD15201@suse.de>
Message-ID: <Pine.GSO.4.21.0207241327250.13170-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 24 Jul 2002, Jens Axboe wrote:

> > 3) DAC960.  Eep.  At some point it's all going to be SCSI, right?
> 
> Nah not really, at some point it will just be the 'disk' sub system.
> BTW, you also forgot at least cpqarray and cciss :-)

... along with paride.  And assorted floppies.  And oddball CDROMs.
And nbd.  And...

IOW, Daniel would really benefit from learning to use grep...

