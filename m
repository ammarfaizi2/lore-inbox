Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUDKPIV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 11:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUDKPIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 11:08:21 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:44217 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S261439AbUDKPIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 11:08:20 -0400
Date: Sun, 11 Apr 2004 08:07:47 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: shai@ftcon.com, "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Darren Hart'" <dvhltc@us.ibm.com>
cc: "'lkml'" <linux-kernel@vger.kernel.org>, ak@suse.de,
       "'Rick Lindsley'" <ricklind@us.ibm.com>, akpm@osdl.org,
       "'Ingo Molnar'" <mingo@elte.hu>
Subject: RE: 2.6.5-rc3-mm4 x86_64 sched domains patch
Message-ID: <1330000.1081696038@[10.10.2.4]>
In-Reply-To: <200404110857.BIS60109@ms6.netsolmail.com>
References: <200404110857.BIS60109@ms6.netsolmail.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can SLIT/SRAT be used here to define topology for the generic case?
> 
> SRAT is being used by i386 to build zonelists, but not for the scheduler -
> any good reason why?

Because it's not generic to all machines. 

M.

