Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbVLEQRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbVLEQRf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 11:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbVLEQRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 11:17:34 -0500
Received: from rtr.ca ([64.26.128.89]:32926 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932371AbVLEQRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 11:17:34 -0500
Message-ID: <4394681B.20608@rtr.ca>
Date: Mon, 05 Dec 2005 11:17:31 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
Cc: Adrian Bunk <bunk@stusta.de>, David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de> <4391D335.7040008@unsolicited.net> <20051203175355.GL31395@stusta.de> <200512042131.13015.rob@landley.net>
In-Reply-To: <200512042131.13015.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>Ahh OK .. I don't use it, so wouldn't have been affected. That's one
>>>userspace interface broken during the series, does anyone have any more?

Ah.. another one, that I was just reminded of again
by the umpteenth person posting that their wireless
no longer is WPA capable after upgrading from 2.6.12.

Of course, the known solution for that issue is to
upgrade to the recently "fixed" latest wpa_supplicant
daemon in userspace, since the old one no longer works.

Things like this are all too regular an occurance.

Cheers
