Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTHVQVb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 12:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTHVQVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 12:21:31 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:63759 "EHLO k2.dsa-ac.de")
	by vger.kernel.org with ESMTP id S263172AbTHVQV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 12:21:28 -0400
Date: Fri, 22 Aug 2003 18:21:24 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: <irda-users@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Cc: <pl@dsa-ac.de>
Subject: Re: [PATCH] + IrDA state
In-Reply-To: <Pine.LNX.4.33.0308221632200.2856-100000@pcgl.dsa-ac.de>
Message-ID: <Pine.LNX.4.33.0308221818410.2856-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...One more thing I forgot to mention - with our patch, sent in the
previous email, 2.4.13 didn't Oops any more, it runs until all RAM leaks
away - about 24 hours, depending on the frequency of connection
establishment... With 2.4.21 it does Oops.

Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

