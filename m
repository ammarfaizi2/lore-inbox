Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbUA2MNF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 07:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265895AbUA2MNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 07:13:05 -0500
Received: from gate.crashing.org ([63.228.1.57]:2535 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265808AbUA2MND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 07:13:03 -0500
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugang <hugang@soulinfo.com>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040129165119.553403f1@localhost>
References: <20040119105237.62a43f65@localhost>
	 <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux>
	 <1074490463.10595.16.camel@gaston> <1074534964.2505.6.camel@laptop-linux>
	 <1074549790.10595.55.camel@gaston> <20040122211746.3ec1018c@localhost>
	 <1074841973.974.217.camel@gaston> <20040123183030.02fd16d6@localhost>
	 <1074912854.834.61.camel@gaston> <20040126181004.GB315@elf.ucw.cz>
	 <1075154452.6191.91.camel@gaston> <1075156310.2072.1.camel@laptop-linux>
	 <20040128202217.0a1f8222@localhost> <1075336478.30623.317.camel@gaston>
	 <20040129100554.6453e6c8@localhost> <1075350214.1231.18.camel@gaston>
	 <20040129165119.553403f1@localhost>
Content-Type: text/plain
Message-Id: <1075378330.1241.37.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 29 Jan 2004 23:12:11 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The ppc part I has lost something, They are has a step to show bug.
> switch to vt console, login as normal use, run "screen", do suspend.
> after resume, screen will say unknown error 514.
> 
> attached file should fix it. but look very very ulgy.

I'll have a look tomorrow, that code was a quick hack indeed.

Ben.


