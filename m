Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422741AbWBNSOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422741AbWBNSOZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422743AbWBNSOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:14:25 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:39076 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1422741AbWBNSOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:14:24 -0500
Date: Tue, 14 Feb 2006 19:14:21 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] make INPUT a bool
In-Reply-To: <20060214152218.GI10701@stusta.de>
Message-ID: <Pine.LNX.4.61.0602141912580.32490@yvahk01.tjqt.qr>
References: <20060214152218.GI10701@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Make INPUT a bool.
>
>INPUT!=y is only possible if EMBEDDED=y, and in such cases it doesn't 
>make that much sense to make it modular.
>
modular would make sense to me - http://lkml.org/lkml/2006/1/25/106

>This patch was already sent on:
>- 3 Feb 2006


Jan Engelhardt
-- 
