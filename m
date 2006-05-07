Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWEGURj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWEGURj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 16:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWEGURj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 16:17:39 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:34185 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932223AbWEGURi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 16:17:38 -0400
Date: Sun, 7 May 2006 22:17:33 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: a Linux swap storm
In-Reply-To: <200605071931.k47JVbs18224@apps.cwi.nl>
Message-ID: <Pine.LNX.4.61.0605072216450.19824@yvahk01.tjqt.qr>
References: <200605071931.k47JVbs18224@apps.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>% display -size 300x300 *.jpg

>I wonder what precisely happened. Is this an X bug? Or a kernel bug?
>The effect is reproducible.

Right before it starts to swap, hit Ctrl+Z to suspend 'display' and do a 
`ps u`. Does it hog memory?


Jan Engelhardt
-- 
