Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266893AbUBFVZu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 16:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266914AbUBFVZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 16:25:50 -0500
Received: from h24-78-210-69.ss.shawcable.net ([24.78.210.69]:60424 "HELO
	discworld.dyndns.org") by vger.kernel.org with SMTP id S266893AbUBFVZn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 16:25:43 -0500
Date: Fri, 6 Feb 2004 15:29:43 -0600
From: Charles Cazabon <linux@discworld.dyndns.org>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: FATAL: Kernel too old
Message-ID: <20040206152943.B26348@discworld.dyndns.org>
Mail-Followup-To: Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0402061550440.681@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0402061550440.681@chaos>; from root@chaos.analogic.com on Fri, Feb 06, 2004 at 04:16:32PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson <root@chaos.analogic.com> wrote:
> 
> Script started on Fri Feb  6 15:44:32 2004
> # rlogin -l johnson quark
> ATAL: kernel too old
> # rlogin -l johnson quark
> ATAL: kernel too old

I saw something similar at a customer's site, when someone rooted the box and
replaced the default login shell with a rootkitted/backdoored one in a newer
executable format not supported by the old kernel.

> I crashed it and it rebooted fine, little fsck activity, with
> nothing in any logs that shows there was any problem whatsoever.

Did the problem go away with a reboot?

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:     http://www.qcc.ca/~charlesc/software/
-----------------------------------------------------------------------
