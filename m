Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbUKSQBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbUKSQBJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 11:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbUKSP7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 10:59:12 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:18840 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261449AbUKSP6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 10:58:46 -0500
Date: Fri, 19 Nov 2004 16:58:36 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Hans Reiser <reiser@namesys.com>
cc: tridge@samba.org, linux-kernel@vger.kernel.org
Subject: Re: performance of filesystem xattrs with Samba4
In-Reply-To: <419E1297.4080400@namesys.com>
Message-ID: <Pine.LNX.4.53.0411191658030.13268@yvahk01.tjqt.qr>
References: <16797.41728.984065.479474@samba.org> <419E1297.4080400@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Is this an fsync intensive benchmark?  If no, could you try with
>reiser4?  If yes, you might as well wait for us to optimize fsync first
>in reiser4.

Do I sense an attempt to get more users from non-reiser*fs to reiser4? ;-)


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
