Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031132AbWI0WJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031132AbWI0WJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031131AbWI0WJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:09:29 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:31177 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1031118AbWI0WJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:09:28 -0400
Message-ID: <451AF696.1050201@pobox.com>
Date: Wed, 27 Sep 2006 18:09:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jay Cliburn <jacliburn@bellsouth.net>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, shemminger@osdl.org
Subject: Re: [PATCH 1/1] atl1: Attansic L1 Gigabit Ethernet driver
References: <20060927132345.GC11922@osprey.hogchain.net>
In-Reply-To: <20060927132345.GC11922@osprey.hogchain.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll wait for the update based on Stephen's comments, before reviewing.

As usual for a new driver, it will take a couple rounds of review+update 
to get things straight.  So please be patient :)

And thanks for working on this!

	Jeff


P.S.  I wonder if Attansic would permit upload of their hardware 
programming guide to http://gkernel.sf.net/specs/ ?


