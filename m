Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285418AbRLGFtI>; Fri, 7 Dec 2001 00:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285419AbRLGFs6>; Fri, 7 Dec 2001 00:48:58 -0500
Received: from www.wen-online.de ([212.223.88.39]:46346 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S285418AbRLGFst>;
	Fri, 7 Dec 2001 00:48:49 -0500
Date: Fri, 7 Dec 2001 06:51:06 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Christian Lavoie <clavoie@bmed.mcgill.ca>
cc: Dave Jones <davej@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17-pre5 will not boot
In-Reply-To: <20011207051939Z282747-752+9102@vger.kernel.org>
Message-ID: <Pine.LNX.4.33.0112070649260.747-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2001, Christian Lavoie wrote:

> The kernel was more or less1024kb large (can't remember the exact number),
> and my loadlin can't seem to handle that.

Yes, loadlin has always croaked on >1MB kernels here.

	-Mike

