Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVHFDV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVHFDV2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 23:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbVHFDV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 23:21:28 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:53707 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262057AbVHFDVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 23:21:25 -0400
Subject: Re: 2.6.12-ck5
From: Lee Revell <rlrevell@joe-job.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, ck list <ck@vds.kolivas.org>
In-Reply-To: <200508061247.44391.kernel@kolivas.org>
References: <200508061247.44391.kernel@kolivas.org>
Content-Type: text/plain
Date: Fri, 05 Aug 2005 23:21:20 -0400
Message-Id: <1123298480.4788.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-06 at 12:47 +1000, Con Kolivas wrote:
> SCHED_ISO was dropped entirely. It broke in ck4, and there is now a
> decent defacto standard for unprivileged realtime in mainline kernel
> with realtime RLIMITS so I'm supporting the use of that instead.

Too bad, this was a nice feature, but it seems like a hard problem (even
OSX does not really do isochronous scheduling despite when the developer
guides say).  It would be good to revisit this for 2.7.

Lee

