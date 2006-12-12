Return-Path: <linux-kernel-owner+w=401wt.eu-S1751114AbWLLKaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWLLKaH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 05:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWLLKaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 05:30:07 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:46159 "EHLO smtp.hispeed.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751114AbWLLKaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 05:30:05 -0500
Subject: Re: Nokia E61 and the kernel BUG at mm/slab.c:594
From: Thomas Sailer <t.sailer@alumni.ethz.ch>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Joscha Ihl <joscha@grundfarm.de>, linux-kernel@vger.kernel.org,
       ihl@fh-brandenburg.de
In-Reply-To: <20061212094421.GC2818@rhun.haifa.ibm.com>
References: <20061211173506.5c8cb479@localhost>
	 <20061212094421.GC2818@rhun.haifa.ibm.com>
Content-Type: text/plain
Organization: e-vision, inc.
Date: Tue, 12 Dec 2006 11:28:41 +0100
Message-Id: <1165919321.4066.44.camel@playstation2.hb9jnx.ampr.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-01.tornado.cablecom.ch 1378;
	Body=4 Fuz1=4 Fuz2=4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-12 at 11:44 +0200, Muli Ben-Yehuda wrote:

> I assume the previous crash was 2.6.19 with SMP? did it work with
> earlier kernels?

It happens to me as well, current Fedora 6 update
kernel-2.6.18-1.2849.fc6.i686 UP, with a Nokia E70 in "PC Suite" mode.
It works ok in mass storage mode. Haven't had time to debug this,
though...

Tom


