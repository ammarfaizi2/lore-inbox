Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbTH1Rff (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 13:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263617AbTH1Rfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 13:35:33 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:20103 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263587AbTH1Rfb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 13:35:31 -0400
Date: Thu, 28 Aug 2003 18:35:22 +0100
From: Jamie Lokier <jamie@shareable.org>
To: root@mauve.demon.co.uk
Cc: Ragnar Hojland Espinosa <ragnar@linalco.com>,
       David Schwartz <davids@webmaster.com>, Timo Sirainen <tss@iki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading
Message-ID: <20030828173522.GA8581@mail.jlokier.co.uk>
References: <20030828130326.GF6800@mail.jlokier.co.uk> <200308281726.SAA24033@mauve.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308281726.SAA24033@mauve.demon.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root@mauve.demon.co.uk wrote:
> > Probability on the order of 2^-32 with MD5 any-pairs collision.
> MD5 is 128 bit output, so that's around 2^64 pairs before you have a birthday.

Right.  Dozy me :)

> > Do you still have the GIFs?
> 
> There arn't that many GIFs in the world.
> I'd be really surprised if there were that many pictures in the world.

I'd be really surprised if what you saw wasn't a software error,
misreporting or miscalculating the MD5.

-- JAmie
