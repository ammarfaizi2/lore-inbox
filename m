Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271900AbTHEU6p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 16:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271903AbTHEU6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 16:58:45 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:42669 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S271900AbTHEU6e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 16:58:34 -0400
Date: Tue, 5 Aug 2003 22:57:35 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <Andries.Brouwer@cwi.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix error return get/set_native_max functions
In-Reply-To: <UTC200308052027.h75KRQI23589.aeb@smtp.cwi.nl>
Message-ID: <Pine.SOL.4.30.0308052245380.4251-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Aug 2003 Andries.Brouwer@cwi.nl wrote:

> By the way, is your tree visible somewhere?

Not yet.

> I have a giant patch with quite a lot of improvements and
> minor bug fixes, all in the geometry / IDENTIFY area.

Giant patch? :( Can you split it?

Splitting on obvious & non-obvious parts will help greatly.
Obvious parts can go into Linus' tree quickly.

> Usually I diff against Linus' most recent version, but we
> already had one by Erik and two by me, and stuff overlaps,
> and I do not yet see any of this in Linus' tree.

Because it takes a while to check them
(especially if they are not splitted).

--
Bartlomiej

