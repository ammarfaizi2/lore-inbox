Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267685AbUHJT5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267685AbUHJT5Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 15:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267686AbUHJT5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 15:57:24 -0400
Received: from fmr05.intel.com ([134.134.136.6]:12940 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S267685AbUHJT5X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 15:57:23 -0400
Subject: Re: 2.6.8-rc4-mm1 : Hard freeze due to ACPI
From: Len Brown <len.brown@intel.com>
To: Eric Valette <eric.valette@free.fr>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Karol Kozimor <sziwan@hell.org.pl>
In-Reply-To: <411927C9.9040300@free.fr>
References: <41189098.4000400@free.fr>  <4118A500.1080306@free.fr>
	 <1092151779.5028.40.camel@dhcppc4> <41191929.4090305@free.fr>
	 <411927C9.9040300@free.fr>
Content-Type: text/plain
Organization: 
Message-Id: <1092167817.5021.89.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 10 Aug 2004 15:56:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 15:53, Eric Valette wrote:
> Eric Valette wrote:
> 
> > Will try andrew suggestion for the video-mode-handling-* patch
> 
> Tried without success. Will wait until other find other symptoms for
> the 
> same problem.
> 

I suppose with the patches available  broken out, you can apply them
in groups and divide & conquor.

I'd be interested to know if the latest bk-acpi.patch is related to
the issue...

thanks,
-Len


