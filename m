Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbUCVW3X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 17:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbUCVW3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 17:29:23 -0500
Received: from smtp.terra.es ([213.4.129.129]:55010 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S262266AbUCVW3W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 17:29:22 -0500
Date: Mon, 22 Mar 2004 23:27:23 +0100
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: jos@hulzink.net, linux-kernel@vger.kernel.org
Subject: Re: OSS: cleanup or throw away
Message-Id: <20040322232723.780ab026.diegocg@teleline.es>
In-Reply-To: <20040322215709.GT16746@fs.tum.de>
References: <200403221955.52767.jos@hulzink.net>
	<20040322215709.GT16746@fs.tum.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 22 Mar 2004 22:57:09 +0100 Adrian Bunk <bunk@fs.tum.de> escribió:

> OSS will stay in 2.6 (2.6 is a stable kernel series) but it will most
> likely be removed in 2.7.

Personally, as an user, I'd like to have the OSS drivers which don't have
a ALSA equivalent for my old hardware. There're several
sound cards with both ALSA and OSS drivers where ALSA works
much better 99% of the time. Those could be safely removed
(even in the 2.6 timeframe, I'd argue) but I'd like to keep the ones
without an alsa equivalent for my old hardware (specially now that we
have a -tiny tree ;) however I can understand that if they don't
have a maintainer they'll get removed...
