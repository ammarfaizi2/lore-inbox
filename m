Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270373AbSISIGI>; Thu, 19 Sep 2002 04:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270446AbSISIGH>; Thu, 19 Sep 2002 04:06:07 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:28938
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S270373AbSISIF6>; Thu, 19 Sep 2002 04:05:58 -0400
Subject: Re: 2.5.36-mm1
From: Robert Love <rml@tech9.net>
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
In-Reply-To: <3D8839B5.B37DF31C@digeo.com>
References: <3D8839B5.B37DF31C@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 19 Sep 2002 04:10:55 -0400
Message-Id: <1032423056.16889.21.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-18 at 04:30, Andrew Morton wrote:

> A reminder that this changes /proc files.  Updated top(1) and
> vmstat(1) source is available at http://surriel.com/procps/

Note to those testing 2.5-mm with the new top(1) and vmstat(1) changes:
I have made RPMs available:

	http://tech9.net/rml/procps/

Besides the VM statistics improvements, there are some other nice
changes from Rik, myself, et al, being merged into the procps package.

	Robert Love


