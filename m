Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbTFIRcX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 13:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbTFIRcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 13:32:23 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:4547 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id S263676AbTFIRcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 13:32:23 -0400
Date: Mon, 9 Jun 2003 19:45:58 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm6
In-Reply-To: <20030607151440.6982d8c6.akpm@digeo.com>
Message-ID: <Pine.LNX.4.51.0306091943580.23392@dns.toxicfilms.tv>
References: <20030607151440.6982d8c6.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> . -mm kernels will be running at HZ=100 for a while.  This is because
>   the anticipatory scheduler's behaviour may be altered by the lower
>   resolution.  Some architectures continue to use 100Hz and we need the
>   testing coverage which x86 provides.
The interactivity seems to have dropped. Again, with common desktop
applications: xmms playing with ALSA, when choosing navigating through
evolution options or browsing with opera, music skipps.
X is running with nice -10, but with mm5 it ran smoothly.

Regards,
Maciej

