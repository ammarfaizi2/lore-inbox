Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267773AbUI1NHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267773AbUI1NHk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 09:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267770AbUI1NHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 09:07:40 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:61022 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S267773AbUI1NHg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 09:07:36 -0400
Subject: Re: 2.6.9-rc2-mm4
From: Paul Fulghum <paulkf@microgate.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Gene Heskett <gene.heskett@verizon.net>,
       Matt Heler <lkml@lpbproductions.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040927230119.GA31278@elte.hu>
References: <20040926181021.2e1b3fe4.akpm@osdl.org>
	 <200409270053.22911.gene.heskett@verizon.net>
	 <20040927201928.GB19257@elte.hu>
	 <1096317273.2523.5.camel@deimos.microgate.com>
	 <20040927204557.GA22542@elte.hu>  <20040927230119.GA31278@elte.hu>
Content-Type: text/plain
Message-Id: <1096376849.2521.0.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 28 Sep 2004 08:07:29 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 18:01, Ingo Molnar wrote:
> could you try the patch below ontop of -mm4 and try again the .config
> that failed before? Does the bootup still hang?

The patch fixes the boot hang.

Thanks

-- 
Paul Fulghum
paulkf@microgate.com

