Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTESUag (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 16:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262793AbTESUag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 16:30:36 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:951
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262805AbTESUaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 16:30:35 -0400
Subject: RE: HD DMA disabled in 2.4.21-rc2, works fine in 2.4.20
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: "Mudama, Eric" <eric_mudama@maxtor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1053374646.10240.5.camel@heat>
References: <785F348679A4D5119A0C009027DE33C102E0D3AB@mcoexc04.mlm.maxtor.com>
	 <1053374646.10240.5.camel@heat>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053373513.29226.25.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 May 2003 20:45:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-19 at 21:04, Jeffrey W. Baker wrote:
> I was using Via IDE chipset and, yes, I had configured the kernel for
> VIA support.  That's why it worked in 2.4.20.  But it stopped working in
> 2.4.21-rc.

VIA IDE should be working reliably, my main test box is an EPIA series
VIA system so the VIA IDE does get a fair beating
