Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSLCMPm>; Tue, 3 Dec 2002 07:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSLCMPm>; Tue, 3 Dec 2002 07:15:42 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:48052 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261448AbSLCMPl>;
	Tue, 3 Dec 2002 07:15:41 -0500
Date: Tue, 3 Dec 2002 12:18:58 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Vamsi Krishna S ." <vamsi@in.ibm.com>
Cc: torvalds@transmeta.com, lkml <linux-kernel@vger.kernel.org>,
       dprobes <dprobes@www-124.southbury.usf.ibm.com>,
       richard <richardj_moore@uk.ibm.com>, tom <hanrahat@us.ibm.com>
Subject: Re: [PATCH] kprobes for 2.5.50-bk2
Message-ID: <20021203121858.GC30431@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Vamsi Krishna S ." <vamsi@in.ibm.com>, torvalds@transmeta.com,
	lkml <linux-kernel@vger.kernel.org>,
	dprobes <dprobes@www-124.southbury.usf.ibm.com>,
	richard <richardj_moore@uk.ibm.com>, tom <hanrahat@us.ibm.com>
References: <20021203125447.A2951@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021203125447.A2951@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 12:54:47PM +0530, Vamsi Krishna S . wrote:

 > kprobes allows trapping at almost any kernel address, useful for
 > various kernel-hacking tasks, and building on for more
 > infrastructure.

This last part just got me thinking.
What stops someone for example using this to implement a binary
only replacement of the TCP/IP stack, or any other part of the
kernel for that matter ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
