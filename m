Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbTLDBIP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 20:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbTLDBIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 20:08:15 -0500
Received: from main.gmane.org ([80.91.224.249]:31142 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262859AbTLDBIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 20:08:12 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Happe <andreashappe@gmx.net>
Subject: Re: [2.6.0-test10(-mm1)] 8139too vs. 8139cp
Date: Thu, 4 Dec 2003 02:08:03 +0100
Message-ID: <slrnbst27j.15m.andreashappe@flatline.ath.cx>
References: <slrnbssbve.16d.andreashappe@flatline.ath.cx> <20031203192611.GA17676@gtf.org>
Reply-To: Andreas Happe <andreashappe@gmx.net>
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-12-03, Jeff Garzik <jgarzik@pobox.com> wrote:
> Please try -test11, it should have a fix in 8139cp for this...

the computer just crashed running 8139cp unter 2.6.0-test11-bk1, I
switched back to the 8139too driver (this time there wasn't any video or
audio running in background).

	--Andreas

