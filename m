Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279505AbRKFOkF>; Tue, 6 Nov 2001 09:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279556AbRKFOjp>; Tue, 6 Nov 2001 09:39:45 -0500
Received: from sushi.toad.net ([162.33.130.105]:48005 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S279505AbRKFOjk>;
	Tue, 6 Nov 2001 09:39:40 -0500
Subject: Re: [PATCH] PnPBIOS patch #11
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 06 Nov 2001 09:39:00 -0500
Message-Id: <1005057542.920.68.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please dont code on that basis. I added the locks and the like so that
> when I get a docking event I can eventually rescan the pnpbios data
> and hot plug/unplug devices

Sorry, I was just trying to make the driver consistent with
itself as it is now, rather than with how it will be after
you change it to support rescanning.

Please use those parts of patch #11 that seem okay to you, if any.
It's all "cleanup" stuff.  Note, though, that Christian Schmidt
asked that his e-mail address be changed.


