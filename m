Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263857AbTKLATz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 19:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263860AbTKLATz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 19:19:55 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:12706
	"EHLO x30.random") by vger.kernel.org with ESMTP id S263857AbTKLATz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 19:19:55 -0500
Date: Wed, 12 Nov 2003 01:19:10 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Larry McVoy <lm@work.bitmover.com>, Andrew Walrond <andrew@walrond.org>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031112001910.GZ1649@x30.random>
References: <fa.eto0cvm.1v20528@ifi.uio.no> <200311111438.47868.andrew@walrond.org> <bore48$ubl$1@cesium.transmeta.com> <200311112021.34631.andrew@walrond.org> <20031111235215.GA22314@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031111235215.GA22314@work.bitmover.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 03:52:15PM -0800, Larry McVoy wrote:
> going to start a flame war.  So I won't.  I will note that none of the
> solutions proposed come close to being acceptable, they all fail on NFS
> and on SMB shares.  And they don't cascade properly as HPA has noted.

FWIW arch would solve this completely too, but we need to checkout a
coherent cvs to import the data into arch.
