Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265655AbUATSv3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265657AbUATSv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:51:29 -0500
Received: from 0x50a144fa.albnxx15.adsl-dhcp.tele.dk ([80.161.68.250]:260 "EHLO
	0x50a144fa.albnxx15.adsl-dhcp.tele.dk") by vger.kernel.org with ESMTP
	id S265655AbUATSv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:51:27 -0500
Date: Tue, 20 Jan 2004 19:51:22 +0100
From: Rask Ingemann Lambertsen <rask@sygehus.dk>
To: Jim Keniston <jkenisto@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev <netdev@oss.sgi.com>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       "Feldman, Scott" <scott.feldman@intel.com>,
       Larry Kessler <kessler@us.ibm.com>
Subject: Re: [PATCH 2.6.1] Net device error logging
Message-ID: <20040120195122.A1087@sygehus.dk>
References: <400C3D3E.BFCC25CE@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <400C3D3E.BFCC25CE@us.ibm.com>; from jkenisto@us.ibm.com on Mon, Jan 19, 2004 at 12:25:34PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 12:25:34PM -0800, Jim Keniston wrote:
> The enclosed patch implements the netdev_* error-logging macros for
> network drivers.  These macros have been discussed at length on the
> linux-kernel and linux-netdev lists.  All issues that reviewers have
> raised were addressed previously.  This is just an update for v2.6.1.

How about a message rate limit?

-- 
Regards,
Rask Ingemann Lambertsen
