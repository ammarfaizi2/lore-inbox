Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267661AbUHTHxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267661AbUHTHxm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 03:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267670AbUHTHxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 03:53:42 -0400
Received: from palrel12.hp.com ([156.153.255.237]:10711 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S267661AbUHTHxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 03:53:38 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16677.44536.108916.524865@napali.hpl.hp.com>
Date: Fri, 20 Aug 2004 00:53:28 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davidm@hpl.hp.com, Jesse Barnes <jbarnes@engr.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernbench on 512p
In-Reply-To: <1092938120.28370.15.camel@localhost.localdomain>
References: <200408191216.33667.jbarnes@engr.sgi.com>
	<16676.54657.220755.148837@napali.hpl.hp.com>
	<200408191237.16959.jbarnes@engr.sgi.com>
	<16676.55284.896783.567359@napali.hpl.hp.com>
	<1092938120.28370.15.camel@localhost.localdomain>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 19 Aug 2004 18:55:22 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> said:

  Alan> On Iau, 2004-08-19 at 17:40, David Mosberger wrote:
  >> Why not file a bug-report to Red Hat instead?  guile v1.6 and the
  >> guile-SLIB are quite old and rather standard.

  Alan> On debian maybe.

  Alan> The enterprise demand for guile-slib is suprisingly low ;)

Ever heard of the chicken-and-egg problem?

Is there any good reason _not_ to provide guile-slib?  I'm not aware of any.

	--david
