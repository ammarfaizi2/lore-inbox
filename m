Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbTJXPdx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 11:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbTJXPdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 11:33:53 -0400
Received: from fmr04.intel.com ([143.183.121.6]:40628 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262298AbTJXPdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 11:33:52 -0400
Subject: Re: Linux 2.4.23-pre8
From: Len Brown <len.brown@intel.com>
To: Tony Gale <gale@syntax.dstl.gov.uk>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1067008275.6437.6.camel@syntax.dstl.gov.uk>
References: <Pine.LNX.4.44.0310222116270.1364-100000@dstl.gov.uk>
	 <1067008275.6437.6.camel@syntax.dstl.gov.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1067009626.2592.31.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Oct 2003 11:33:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the note Tony.
Can you direct me to the bug report?
If there isn't one yet, please file one and assign it to me.

thanks,
-Len

http://bugzilla.kernel.org/
Category: Power Management
Component: ACPI


On Fri, 2003-10-24 at 11:11, Tony Gale wrote:
> On Thu, 2003-10-23 at 00:24, Marcelo Tosatti wrote:
> > Hi, 
> > 
> > Here goes -pre8... It contains a quite big amount of ACPI fixes,
> > networking changes, network driver changes, few IDE fixes, SPARC merge, SH
> > merge, tmpfs fixes, NFS fixes, important VM typo fix, amongst others.
> > 
> 
> As reported earlier, this still fails to boot on my P-II (to recap,
> pre6, pre7 and pre8 fail to boot - no messages after Uncompressing
> kernel).
> 
> Reverting the ACPI changes in pre6 fixes it - note that I have ACPI
> turned off in the config, so the CONFIG_ACPI_BOOT thing is causing the
> problem, and it seems to be impossible to compile a kernel without it.
> 
> Cheers,
> -tony
> 

