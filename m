Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269957AbTGKNcP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 09:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269960AbTGKNcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 09:32:15 -0400
Received: from hera.cwi.nl ([192.16.191.8]:13493 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S269957AbTGKNcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 09:32:14 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 11 Jul 2003 15:46:55 +0200 (MEST)
Message-Id: <UTC200307111346.h6BDktG25627.aeb@smtp.cwi.nl>
To: ahu@ds9a.nl, andries.brouwer@cwi.nl
Subject: Re: what is needed to test the in-kernel crypto loop?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is a newer losetup/mount needed to test the in-kernel crypto loop driver?

Yes.

[Or at least: a nonstandard losetup/mount. The patches distributed
for jari-loop or kerneli-loop also contain a patched losetup.]

Try util-linux 2.12, available in 60 hours.

Andries
