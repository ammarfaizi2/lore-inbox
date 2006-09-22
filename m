Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbWIVOLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWIVOLb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWIVOLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:11:31 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34518 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932513AbWIVOLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:11:30 -0400
Date: Fri, 22 Sep 2006 16:11:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Scott E. Preece" <preece@motorola.com>
Cc: eugeny.mints@gmail.com, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Message-ID: <20060922141127.GM3478@elf.ucw.cz>
References: <200609192137.k8JLb4NX029061@olwen.urbana.css.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609192137.k8JLb4NX029061@olwen.urbana.css.mot.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hmm. If you assume the CPUs in an SMP system can be in different
> operating points, this would (as Pavel pointed out) result in an
> explosion of operating points.

Problem is not only CPUs, devices are mostly independent in PC
case... it would be nice to solve that problem with same approach.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
