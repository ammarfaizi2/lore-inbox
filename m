Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261999AbREPQ2o>; Wed, 16 May 2001 12:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262000AbREPQ2e>; Wed, 16 May 2001 12:28:34 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:29202 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261999AbREPQ2T>; Wed, 16 May 2001 12:28:19 -0400
From: "H. Peter Anvin" <hpa@transmeta.com>
Message-ID: <3B02AA8C.DB122754@transmeta.com>
Date: Wed, 16 May 2001 09:27:56 -0700
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Getting FS access events
In-Reply-To: <200105152231.f4FMVSC246046@saturn.cs.uml.edu>
	 <5.1.0.14.2.20010516020702.00acce40@pop.cus.cam.ac.uk> <5.1.0.14.2.20010516092326.00b217c0@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> True, but I was under the impression that Linus' master plan was that the
> two would be in entirely separate name spaces using separate cached copies
> of the device blocks.
> 

Nothing was said about the superblock at all.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
