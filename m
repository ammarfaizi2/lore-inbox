Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbUK3Xry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbUK3Xry (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbUK3Xqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:46:35 -0500
Received: from mail11.bluewin.ch ([195.186.18.61]:8918 "EHLO mail11.bluewin.ch")
	by vger.kernel.org with ESMTP id S262446AbUK3Xpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:45:36 -0500
Date: Wed, 1 Dec 2004 00:45:26 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6] via-rhine: WOL band-aid
Message-ID: <20041130234526.GA32741@k3.hellgate.ch>
References: <20041130224014.GD29947@k3.hellgate.ch> <41ACFFA0.2030904@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ACFFA0.2030904@pobox.com>
X-Operating-System: Linux 2.6.10-rc2-bk11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004 18:17:52 -0500, Jeff Garzik wrote:
> I don't object to the patch, but I wonder if anything can be done to 
> reduce the usage of "magic numbers" (numeric rather than named constants)?

That's a non-trivial task if you want to do it properly. There be dragons.
Magic numbers may be evil but at least they are honest and convenient.

Roger
