Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTEBUsO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 16:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbTEBUsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 16:48:14 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:56542 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263171AbTEBUsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 16:48:13 -0400
Date: Fri, 2 May 2003 16:36:57 -0400
From: Ben Collins <bcollins@debian.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH] fix mach64_gx.c
Message-ID: <20030502203657.GP426@phunnypharm.org>
References: <16050.3732.615164.697680@argo.ozlabs.ibm.com> <Pine.LNX.4.44.0305022106110.15173-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305022106110.15173-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 02, 2003 at 09:07:32PM +0100, James Simmons wrote:
> 
> New fixes for the ATI driver are coming. I have been neglecting the 
> drivers to finish core changes which for the most part have been done.
> 
> P.S
>    Has anyone tested this chipset on a PPC 64?

FYI, James. This fix is something I already pushed to Dave, so Linus
will get it already.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
