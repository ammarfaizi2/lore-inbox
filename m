Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264958AbUE0S17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264958AbUE0S17 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 14:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUE0S1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 14:27:23 -0400
Received: from acolyte.scowler.net ([216.254.112.45]:22477 "EHLO
	acolyte.scowler.net") by vger.kernel.org with ESMTP id S264956AbUE0SZe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 14:25:34 -0400
Date: Thu, 27 May 2004 14:25:31 -0400
From: Clint Adams <schizo@debian.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, prism54-devel@prism54.org,
       debian-kernel@lists.debian.org
Subject: Re: [Prism54-devel] Re: [PATCH 0/14] prism54: bring up to sync with prism54.org cvs rep
Message-ID: <20040527182531.GA8942@scowler.net>
Mail-Followup-To: Clint Adams <schizo@debian.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	"Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com, prism54-devel@prism54.org,
	debian-kernel@lists.debian.org
References: <20040524083003.GA3330@ruslug.rutgers.edu> <40B63132.4050906@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B63132.4050906@pobox.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >[PATCH 8/14 linux-2.6.7-rc1] prism54: Fix prism54.org bugs 39, 73

> I'm considering rejecting the entire series because of this obfuscation 
> of changes, and getting you to resend with the whitespace crapola 
> separated out.

Please at least apply the changes in the "8/14" patch, because without
them the driver is unusable on big-endian architectures.
