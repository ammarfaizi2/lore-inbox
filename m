Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTFXJq7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 05:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTFXJq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 05:46:58 -0400
Received: from [213.196.40.44] ([213.196.40.44]:6316 "EHLO blackstar.nl")
	by vger.kernel.org with ESMTP id S261265AbTFXJq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 05:46:58 -0400
Date: Tue, 24 Jun 2003 11:50:05 +0200 (CEST)
From: Bas Vermeulen <bvermeul@blackstar.nl>
To: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Problems with PCMCIA/Orinoco
In-Reply-To: <20030624005912.GA23266@butterfly.hjsoft.com>
Message-ID: <Pine.LNX.4.33.0306241148450.14587-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jun 2003, John M Flinchbaugh wrote:

> On Mon, Jun 23, 2003 at 10:38:15AM +0100, Russell King wrote:
> > > unregister_netdevice: waiting for eth1 to become free. Usage count 
> = 1
> > Is this still an outstanding problem in 2.5.73?
> 
> i still see it with both my 3c574_cs and my orinoco_cs in 2.5.73.
> this one is elusive, isn't it?  if i were smarter, i'd try to track it
> down.  maybe i'll look at it again, not that i know anything.

Still see it here as well. I'll try to track it down tonight, when I've 
got some free time on my hands.

Bas Vermeulen

-- 
"God, root, what is difference?" 
	-- Pitr, User Friendly

"God is more forgiving." 
	-- Dave Aronson

