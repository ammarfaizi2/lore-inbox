Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbTFDWSW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 18:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264248AbTFDWSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 18:18:21 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9862
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264246AbTFDWSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 18:18:16 -0400
Subject: Re: 2.4.21-rc7 SMP module unresolved symbols
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel.A.Christian@NASA.gov
Cc: John Appleby <john@dnsworld.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200306041106.01316.Daniel.A.Christian@NASA.gov>
References: <434747C01D5AC443809D5FC5405011314BEC@bobcat.unickz.com>
	 <200306041106.01316.Daniel.A.Christian@NASA.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054762417.14284.76.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Jun 2003 22:33:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-04 at 19:06, Dan Christian wrote:
> "make mrproper" fixes it.
> 
> For the record, I think this stinks!

Fixed in 2.5 - but rewriting the config system for the stable release
is "problematic"


