Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTKYKzV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 05:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbTKYKzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 05:55:21 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:30359 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262323AbTKYKzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 05:55:17 -0500
Date: Tue, 25 Nov 2003 11:55:15 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Copy protection of the floppies
Message-ID: <20031125105515.GA8887@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <5F0021EEA434D511BE7300D0B7B6AB530CA67677@mail2.ggn.hcltech.com> <20031125.182844.46174767.yoshfuji@linux-ipv6.org> <yw1xu14sdbwo.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xu14sdbwo.fsf@kth.se>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Nov 2003, Måns Rullgård wrote:

> YOSHIFUJI Hideaki / .$B5HF#1QL@.(B <yoshfuji@linux-ipv6.org> writes:
> 
> > Basically, it depends on what kind of equipment you and the enemy
> > have.  If you have special equipment and technique to write a
> > floppy, you can make a floppy which is not copiable by normal PCs.
> > But, if the enemy has similar equipment, he can do it.
> >
> > About 15 years ago, there were many gaming softwares which were procected,
> > for example, by checking "gap" between sectors.
> 
> Can't that be done with a regular floppy drive and some special
> software?

It depends. Checking gap length (exactly) and location of one track
relative to the next would require drives with synchronized spindles to
copy the data iff the gap information is used as encryption key. Whether
Linux is up to the task, is something different. Last time I tried such
a thing was in the good old Commodore 1541 days which also supported
half-steps between tracks and stepping after 1/3rd track or some things.
