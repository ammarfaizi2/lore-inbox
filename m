Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbVHEUDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbVHEUDu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 16:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbVHEUDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 16:03:47 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:43440 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262908AbVHEUDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 16:03:10 -0400
Subject: Re: local DDOS? Kernel panic when accessing /proc/ioports
From: Lee Revell <rlrevell@joe-job.com>
To: Martin Loschwitz <madkiss@madkiss.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050805192628.GA24706@minerva.local.lan>
References: <20050805192628.GA24706@minerva.local.lan>
Content-Type: text/plain
Date: Fri, 05 Aug 2005 16:03:07 -0400
Message-Id: <1123272188.8003.20.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 21:26 +0200, Martin Loschwitz wrote:
> Ooops and ksymoops-output is attached.

Also, don't use ksymoops for 2.6, it's redundant at best and at worst
actually removes information.  Check oops-tracing.txt, the docs have
been updated.

Lee

