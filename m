Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbTDRPsQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 11:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbTDRPsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 11:48:16 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:40199 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262964AbTDRPsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 11:48:15 -0400
Date: Fri, 18 Apr 2003 11:45:58 -0400 (EDT)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: Bill Davidsen <davidsen@tmr.com>
cc: John Jasen <jjasen@realityfailure.org>, John Bradford <john@grabjohn.com>,
       jlnance@unity.ncsu.edu, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
Subject: Re: RedHat 9 and 2.5.x support
In-Reply-To: <Pine.LNX.3.96.1030418102439.9185A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.10.10304181142200.13892-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 18 Apr 2003, Bill Davidsen wrote:

> The last I looked modprobe.conf was a seriously deficient subset of
> modules.conf, but I haven't d/l the latest version, so some of the
> omissions may have been addressed. The major feature missing is (or was)
> the lack of probe capability (and probeall). 

I think you can achieve the same outcome with a carefully crafted "install"
command in modprobe.conf (granted it will be much more verbose than the
equivalent "probe"). 

Try "man modprobe.conf" after installing Rusty's new modutils...

--
Paul

