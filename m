Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWAOPvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWAOPvq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 10:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWAOPvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 10:51:46 -0500
Received: from sipsolutions.net ([66.160.135.76]:44301 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S932082AbWAOPvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 10:51:45 -0500
Message-ID: <56187.84.135.205.30.1137340292.squirrel@secure.sipsolutions.net>
In-Reply-To: <200601151340.10730.stefan@loplof.de>
References: <20060113195723.GB16166@tuxdriver.com>
    <20060113221935.GJ16166@tuxdriver.com>
    <1137191522.2520.63.camel@localhost>
    <200601151340.10730.stefan@loplof.de>
Date: Sun, 15 Jan 2006 16:51:32 +0100 (CET)
Subject: Re: wireless: recap of current issues (configuration)
From: "Johannes Berg" <johannes@sipsolutions.net>
To: "Stefan Rompf" <stefan@loplof.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Rompf wrote:

> Even though it is a bit more work on kernel side, we should allow changing
> the
> mode of virtual devices. Let's face it, even though we find multi-BSS
> capabilities very interesting, 999 of 1000 users won't care due to the two
> facts that IPW firmware IMHO doesn't allow it and virtual interfaces are
> limited to one channel anyway. These users rightfully expect to have one
> interface and be able to do all configurations on it.

Isn't that rather a question of having good user-space tools that make
deactivating one type of interface and activating another seamless?

johannes
