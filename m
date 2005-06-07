Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVFGSSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVFGSSW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 14:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVFGSSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 14:18:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51645 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261952AbVFGSSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 14:18:20 -0400
Date: Tue, 7 Jun 2005 14:18:17 -0400
From: Dave Jones <davej@redhat.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Michael Thonke <iogl64nx@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Pentium-D support
Message-ID: <20050607181817.GB21495@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Bill Davidsen <davidsen@tmr.com>,
	Michael Thonke <iogl64nx@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42A5B80A.4040709@tmr.com> <42A5C8A3.2090202@gmail.com> <42A5DD47.5090000@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A5DD47.5090000@tmr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 01:45:43PM -0400, Bill Davidsen wrote:

 > >For GCC 3.4.x or 4.0.x you only need the compile switch -march=nocona as
 > >the name of the XEON..but its the same piece of technologie
 > 
 > Okay, unless I can find an Intel-64 build of Fedora I'll have to do it 
 > myself, but now that I know what option to use it's possible.

The standard x86-64 build of Fedora will work just fine.
(I use it daily on em64t)

		Dave

