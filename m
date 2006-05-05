Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWEEPyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWEEPyw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 11:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWEEPyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 11:54:52 -0400
Received: from albireo.ucw.cz ([84.242.87.5]:49795 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S1751152AbWEEPyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 11:54:52 -0400
Date: Fri, 5 May 2006 17:54:52 +0200
From: Martin Mares <mj@ucw.cz>
To: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       dtor_core@ameritech.net, "Martin J. Bligh" <mbligh@mbligh.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Remove silly messages from input layer.
Message-ID: <mj+md-20060505.154834.7444.albireo@ucw.cz>
References: <20060504024404.GA17818@redhat.com> <20060504071736.GB5359@ucw.cz> <445A18D8.1030502@mbligh.org> <d120d5000605041134k3d9f5934ne9e01f7108cb0271@mail.gmail.com> <20060504183840.GE18962@redhat.com> <20060505103123.GB4206@elf.ucw.cz> <20060505152748.GA22870@redhat.com> <mj+md-20060505.153608.7268.albireo@ucw.cz> <20060505154638.GE22870@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505154638.GE22870@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd argue that anything that triggers that many false positives is worthless.

Why do you think these are false positives? They usually report real
problems. Unfortunately a significant fraction of keyboards is crappy
these days, but it's still good to know if the keyboard you are currently
testing is broken or not.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
If a train station is where the train stops, what is a work station?
