Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290731AbSA3XBX>; Wed, 30 Jan 2002 18:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290728AbSA3XBN>; Wed, 30 Jan 2002 18:01:13 -0500
Received: from www.transvirtual.com ([206.14.214.140]:41736 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S290731AbSA3XAz>; Wed, 30 Jan 2002 18:00:55 -0500
Date: Wed, 30 Jan 2002 15:00:27 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Karl <ktatgenhorst@earthlink.net>
cc: Robert Love <rml@tech9.net>, Alex Khripin <akhripin@mit.edu>,
        linux-kernel@vger.kernel.org
Subject: RE: BKL in tty code?
In-Reply-To: <NDBBJHDEALBBOIDJGBNNIEHCCCAA.ktatgenhorst@earthlink.net>
Message-ID: <Pine.LNX.4.10.10201301459170.7609-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>    Is there a specific maintainer for the TTY code. This is the part of the
> kernel which I am most interested in. I have many TTYs in a mid size (100
> user Unix network) and could get to do some testing if anyone is writing
> patches for this system. I would also be willing to do minor review of code
> for spelling and such. I would _really_ like to get involved with this
> specific system.

Thedore Tyso was originally the maintainer but he seems to have
disappeared from the face of the earth. For the past year I have been
working on a totally rewrite of the tty/console system. 

