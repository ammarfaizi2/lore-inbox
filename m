Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVKBAui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVKBAui (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 19:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVKBAui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 19:50:38 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:51596 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932110AbVKBAui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 19:50:38 -0500
Subject: Re: Problem with the default IOSCHED
From: Marcel Holtmann <marcel@holtmann.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0511011631360.11761@shark.he.net>
References: <1130891282.5048.50.camel@blade>
	 <Pine.LNX.4.58.0511011631360.11761@shark.he.net>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 01:50:39 +0100
Message-Id: <1130892639.5048.54.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

> > by accident I selected the anticipatory IO scheduler as default in my
> > kernel config, but only the CFQ was built in. The anticipatory and
> > deadline were only available as modules. This caused an oops at boot.
> > After selecting CFQ as default schedule and a recompile and reboot
> > everything was fine again.
> 
> What kernel version?  There are already some patches
> in 2.6.14-gitN for this kind of problem.
> Have you tried the -git updates?

sorry, I forgot to mention that. It is the latest vanilla you can get.

Regards

Marcel


