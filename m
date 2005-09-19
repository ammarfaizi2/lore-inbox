Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbVISK2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbVISK2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 06:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbVISK2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 06:28:50 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:60644 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932410AbVISK2u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 06:28:50 -0400
Subject: Re: I request inclusion of reiser4 in the mainline kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hans Reiser <reiser@namesys.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <432E5024.20709@namesys.com>
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl>
	 <432E5024.20709@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Sep 2005 11:51:21 +0100
Message-Id: <1127127081.22124.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-09-18 at 22:44 -0700, Hans Reiser wrote:
> We are supposed to write a filesystem so that overheating CPUs do not
> make it crash?

The reverse - and before you lose data.

> I think Alan Cox is the only poster who has no intention of using
> Reiser4 but said at one point that he thinks it should go in.

If its clean enough then yes, like any other fs. Until then no.

