Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270647AbTHEU13 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 16:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270659AbTHEU12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 16:27:28 -0400
Received: from hera.cwi.nl ([192.16.191.8]:5507 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S270647AbTHEU12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 16:27:28 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 5 Aug 2003 22:27:26 +0200 (MEST)
Message-Id: <UTC200308052027.h75KRQI23589.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] fix error return get/set_native_max functions
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By the way, is your tree visible somewhere?

I have a giant patch with quite a lot of improvements and
minor bug fixes, all in the geometry / IDENTIFY area.
Usually I diff against Linus' most recent version, but we
already had one by Erik and two by me, and stuff overlaps,
and I do not yet see any of this in Linus' tree.
Usually I wait with sending the next until I see the previous
patch applied, but when there are many fragments that process
is excruciatingly slow. So, maybe I can come with a series of
patches against your tree?



