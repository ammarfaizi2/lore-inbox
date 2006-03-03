Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752067AbWCCG6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbWCCG6N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 01:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbWCCG6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 01:58:13 -0500
Received: from main.gmane.org ([80.91.229.2]:29411 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1752067AbWCCG6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 01:58:12 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: + pnp-mpu401-adjust-pnp_register_driver-signature.patch added to -mm tree
Date: Fri, 03 Mar 2006 07:58:01 +0100
Message-ID: <pan.2006.03.03.06.58.01.592293@free.fr>
References: <200603022340.k22Neq0o014875@shell0.pdx.osdl.net> <m1veuwgxd8.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le Thu, 02 Mar 2006 17:55:47 -0700, Eric W. Biederman a écrit :

> Huh?
> 
> How do onboard devices or ISA plug and play devices support hot-plug?
> 
Imagine a laptop that can dock on a base station.
The laptop doesn't have midi, the base station have it.


> Or what devices supported by the pnp subsystem support hot-plug?
> 
For pnpacpi yes (maybe some code is still need).
For pnpbios there something for dock event IIRC.


Matthieu


