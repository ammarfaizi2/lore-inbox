Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbVG0UBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVG0UBU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVG0UBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:01:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262311AbVG0T67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 15:58:59 -0400
Date: Wed, 27 Jul 2005 12:57:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kumar Gala <galak@freescale.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 00/14] ppc32: Remove board ports that are no longer
 maintained
Message-Id: <20050727125746.54329281.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0507271029480.12237@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0507271029480.12237@nylon.am.freescale.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala <galak@freescale.com> wrote:
>
> The following board ports are no longer maintained or have become 
>  obsolete:
> 
>  adir
>  ash
>  beech
>  cedar
>  ep405
>  k2
>  mcpn765
>  menf1
>  oak
>  pcore
>  rainier
>  redwood
>  sm850
>  spd823ts
> 
>  We are there for removing support for them.

I'll merge all these into -mm for now, but will hold off sending any of
them upstream pending confirmation of which patches we really want to
proceed with.
