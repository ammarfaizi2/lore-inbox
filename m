Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbTIXRNb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 13:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTIXRNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 13:13:31 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:27793 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S261538AbTIXRNa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 13:13:30 -0400
Date: Wed, 24 Sep 2003 19:13:28 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Matt Heler <lkml@lpbproductions.com>
Cc: Scott Robert Ladd <coyote@coyotegulch.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minimizing the Kernel
In-Reply-To: <200309240939.02316.lkml@lpbproductions.com>
Message-ID: <Pine.LNX.4.51.0309241912480.9178@dns.toxicfilms.tv>
References: <3F71C712.9070503@coyotegulch.com> <200309240939.02316.lkml@lpbproductions.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well for starters dont use gcc 3 or above.. code size has increased
> dramatically with thoose versions. sure they give you more optimization
Hmm, has anyone tried -Os with gcc3+ ?
Maybe that'd be good for size optimization?

Regards,
Maciej

