Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWAFHMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWAFHMd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 02:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWAFHMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 02:12:33 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:15549 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932317AbWAFHMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 02:12:33 -0500
Date: Fri, 6 Jan 2006 08:12:25 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jim Nance <jlnance@sdf.lonestar.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 80 column line limit?
In-Reply-To: <20060106013402.GA9726@SDF.LONESTAR.ORG>
Message-ID: <Pine.LNX.4.61.0601060810120.22809@yvahk01.tjqt.qr>
References: <20060105130249.GB29894@vrfy.org> <20060106013402.GA9726@SDF.LONESTAR.ORG>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Can't we relax the 80 column line rule to something more comfortable?
>
>OMG - The horror
>

Well, I do not see anything wrong with having a very few lines 
(max 2%) exceeding 80 just because a trailing ) or ; won't fit and would 
go into column 81. (I do however limit myself quite strictly, max is 83, 
and that's reall only the corner of corner cases.)


Jan Engelhardt
-- 
