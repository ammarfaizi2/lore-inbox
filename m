Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261619AbSJYVsI>; Fri, 25 Oct 2002 17:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261617AbSJYVsI>; Fri, 25 Oct 2002 17:48:08 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:47885
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261619AbSJYVsH>; Fri, 25 Oct 2002 17:48:07 -0400
Subject: RE: [PATCH] hyper-threading information in /proc/cpuinfo
From: Robert Love <rml@tech9.net>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000ECE7046@fmsmsx103.fm.intel.com>
References: <F2DBA543B89AD51184B600508B68D4000ECE7046@fmsmsx103.fm.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2002 17:54:26 -0400
Message-Id: <1035582867.734.3953.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 17:50, Nakajima, Jun wrote:

> Can you please change "siblings\t" to "threads\t\t". SuSE 8.1, for example,
> is already doing it:

But RedHat apparently is using siblings.  2.4-ac also uses siblings.
And I like "siblings" better so it wins in my opinion.

	Robert Love

