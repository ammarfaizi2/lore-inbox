Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbTEEWDH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 18:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTEEWDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 18:03:07 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:60869 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S261417AbTEEWDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 18:03:05 -0400
Date: Tue, 6 May 2003 00:11:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Gabriel Devenyi <devenyga@mcmaster.ca>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KernelJanitor: Convert remaining error returns to return -E Linux 2.5.68
Message-ID: <20030505221146.GA227@elf.ucw.cz>
References: <200304292215.20590.devenyga@mcmaster.ca> <20030429224228.GQ10374@parcelfarce.linux.theplanet.co.uk> <200304292311.24117.devenyga@mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304292311.24117.devenyga@mcmaster.ca>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It was intended to do exactly what the KernelJanitor TODO and kj.pl script 
> pointed out, but aparently there's more to it than that. (BTW it just says 
> "sed s/return EWHATEVER/return -EWHATEVER/") Discouraging people with foul 
> language isn't the best way to get more developers, this is only my first 
> try.

That's Al Viro, it seems. He is hidding his real name? He's always
like that, and his flames are actually pretty nice reading. [And if
you did not even try to compile/boot that kernel, you deserve them.]


								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
