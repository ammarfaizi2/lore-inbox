Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276639AbSIVGYC>; Sun, 22 Sep 2002 02:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276642AbSIVGYC>; Sun, 22 Sep 2002 02:24:02 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:15122
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S276639AbSIVGYB>; Sun, 22 Sep 2002 02:24:01 -0400
Subject: Re: 2.5.37-mm1
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
In-Reply-To: <3D8D5559.AF112E57@digeo.com>
References: <3D8D5559.AF112E57@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Sep 2002 02:29:11 -0400
Message-Id: <1032676152.967.959.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-22 at 01:30, Andrew Morton wrote:

> Reminder: it breaks top(1) and vmstat(1).  Updates to these tools
> are at http://surriel.com/procps/

FYI, for testers: I have a tarball and RPM available of CVS as of
yesterday, at:

	http://tech9.net/rml/procps/

Rik and I have both been merging some neat code; take a look.

	Robert Love



