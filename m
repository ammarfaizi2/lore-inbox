Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267038AbTCEC1I>; Tue, 4 Mar 2003 21:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267039AbTCEC1I>; Tue, 4 Mar 2003 21:27:08 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:42770
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267038AbTCEC1H>; Tue, 4 Mar 2003 21:27:07 -0500
Subject: Re: Kernel bloat 2.4 vs. 2.5
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: cw@f00f.org, degger@fhm.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20030304183208.61b8ed2d.akpm@digeo.com>
References: <1046817738.4754.33.camel@sonja>
	 <20030304154105.7a2db7fa.akpm@digeo.com> <20030305015957.GA27985@f00f.org>
	 <1046830980.999.78.camel@phantasy.awol.org>
	 <20030304183208.61b8ed2d.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1046831831.999.80.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 04 Mar 2003 21:37:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-04 at 21:32, Andrew Morton wrote:

> well kallsyms is worth 150k.
> 
> Do `strings vmlinux' and take a look at it all.

Oh, yah.  If he has kallsyms enabled that explains most of it.

	Robert Love

