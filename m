Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVEPViL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVEPViL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVEPViK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:38:10 -0400
Received: from dvhart.com ([64.146.134.43]:62881 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261905AbVEPVgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:36:25 -0400
Date: Mon, 16 May 2005 14:36:21 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: 2.6.12-rc4-mm2 boot failure
Message-ID: <743780000.1116279381@flay>
In-Reply-To: <20050516142504.696b443b.akpm@osdl.org>
References: <735450000.1116277481@flay> <20050516142504.696b443b.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, May 16, 2005 14:25:04 -0700 Andrew Morton <akpm@osdl.org> wrote:

> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
>> 
>> PPC64 NUMA box. Maybe this is the same NUMA slab problem you were 
>> hitting before ...
> 
> Probably.  Christoph, this patch has crossed the grief threshold - I'll
> drop it.

OK, fair enough. Christoph, I am interested in seeing your patch work 
... is something that's needed. If you want, I can help you offline 
with some testing on a variety of platforms.

M.

