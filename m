Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbTAVXv2>; Wed, 22 Jan 2003 18:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264716AbTAVXv2>; Wed, 22 Jan 2003 18:51:28 -0500
Received: from holomorphy.com ([66.224.33.161]:47764 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264705AbTAVXv1>;
	Wed, 22 Jan 2003 18:51:27 -0500
Date: Wed, 22 Jan 2003 16:00:32 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [patch][cleanup] Remove __ from topology macros
Message-ID: <20030123000032.GT780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matthew Dobson <colpatch@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>
References: <3E2F2DF4.4000507@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E2F2DF4.4000507@us.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2003 at 03:49:08PM -0800, Matthew Dobson wrote:
> When I originally wrote the patches implementing the in-kernel topology 
> macros, they were meant to be called as a second layer of functions, 
> sans underbars.  This additional layer was deemed unnecessary and 
> summarily dropped.  As such, carrying around (and typing!) all these 
> extra underbars is quite pointless.  Here's a patch to nip this in the 
> (sorta) bud.  The macros only appear in 16 files so far, most of them 
> being the definitions themselves.

This eases my eyes quite a bit. Thanks.

-- wli
