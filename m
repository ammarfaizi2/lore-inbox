Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271421AbTGRJZu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 05:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271441AbTGRJZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:25:50 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.19.221]:37271 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S271421AbTGRJZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:25:48 -0400
Date: Fri, 18 Jul 2003 11:40:34 +0200
From: Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Cc: Danek Duvall <duvall@emufarm.org>, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] O6.1int
Message-ID: <20030718114034.B8542@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Danek Duvall <duvall@emufarm.org>, Con Kolivas <kernel@kolivas.org>
References: <200307171635.25730.kernel@kolivas.org> <20030717080436.GA16509@lorien.emufarm.org> <20030718070749.GA12466@lorien.emufarm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030718070749.GA12466@lorien.emufarm.org>; from duvall@emufarm.org on Fri, Jul 18, 2003 at 12:07:49AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I did discover under O6.1int that I could make xmms block indefinitely
> when opening a window, with fvwm's wire frame manual placement, which I
> hadn't ever noticed before, but I'm not sure if that's because it
> actually wasn't there before, or I just placed the windows more quickly.

The latter, I think. I had similar problems under kwin when moving windows with
"display window contents while moving" unset. I don't seem to be able to
reproduce it now (2.6.0-t1), though.

Rudo.
