Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266295AbUIAMbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUIAMbM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 08:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUIAMbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 08:31:12 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:42198 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266295AbUIAMbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 08:31:06 -0400
Date: Wed, 1 Sep 2004 08:35:32 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Romain Moyne <aero_climb@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Time runs exactly three times too fast
In-Reply-To: <200409021614.10377.aero_climb@yahoo.fr>
Message-ID: <Pine.LNX.4.58.0409010835050.4481@montezuma.fsmlabs.com>
References: <200409021453.09730.aero_climb@yahoo.fr>
 <Pine.LNX.4.58.0409010814580.4481@montezuma.fsmlabs.com>
 <200409021614.10377.aero_climb@yahoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2004, Romain Moyne wrote:

> presario:/etc/rc2.d# ls
> S10sysklogd  S20alsa   S20makedev  S20xprint  S99kdm            S99xdm
> S11klogd     S20exim4  S20pcmcia   S89atd     S99rmnologin
> S14ppp       S20inetd  S20xfs      S89cron    S99stop-bootlogd
> presario:/etc/rc2.d#

Please send a dmesg and .config
