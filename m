Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932743AbWANNsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932743AbWANNsH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 08:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWANNsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 08:48:07 -0500
Received: from khc.piap.pl ([195.187.100.11]:10511 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932715AbWANNsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 08:48:05 -0500
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Stuffed Crust <pizza@shaftnet.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
References: <20060113195723.GB16166@tuxdriver.com>
	<20060113212605.GD16166@tuxdriver.com>
	<20060113213011.GE16166@tuxdriver.com>
	<20060113221935.GJ16166@tuxdriver.com>
	<1137191522.2520.63.camel@localhost>
	<20060114011726.GA19950@shaftnet.org>
	<1137230889.2520.82.camel@localhost>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 14 Jan 2006 14:47:54 +0100
In-Reply-To: <1137230889.2520.82.camel@localhost> (Johannes Berg's message of "Sat, 14 Jan 2006 10:28:09 +0100")
Message-ID: <m3psmu9b05.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> Yeah, this is about what I thought of -- and it makes me wonder if the
> stack really should be aware of the channelization, or if the WiPHY
> driver might better just handle it itself.

The latter, possibly using library functions from the stack :-)
-- 
Krzysztof Halasa
