Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTEBVhz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 17:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbTEBVhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 17:37:55 -0400
Received: from air-2.osdl.org ([65.172.181.6]:34517 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263179AbTEBVhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 17:37:54 -0400
Subject: Re: 2.5.68-mm4
From: Andy Pfiffer <andyp@osdl.org>
To: Steven Cole <elenstev@mesatop.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <1051910420.2166.55.camel@spc9.esa.lanl.gov>
References: <20030502020149.1ec3e54f.akpm@digeo.com>
	 <1051905879.2166.34.camel@spc9.esa.lanl.gov>
	 <20030502133405.57207c48.akpm@digeo.com>
	 <1051908541.2166.40.camel@spc9.esa.lanl.gov>
	 <20030502140508.02d13449.akpm@digeo.com>
	 <1051910420.2166.55.camel@spc9.esa.lanl.gov>
Content-Type: text/plain
Organization: 
Message-Id: <1051912190.14310.2.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 May 2003 14:49:50 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > I found that e100 failed to bring up the
> > > > interface on restart ("failed selftest"), but eepro100 was OK.

> Here is a snippet from dmesg output for a successful kexec e100 boot:

Any chance we could get lspci output from both of these systems?

