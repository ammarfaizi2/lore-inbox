Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbTEQOb3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 10:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbTEQOb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 10:31:29 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6316
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261562AbTEQOb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 10:31:27 -0400
Subject: Re: 2.5.69-mm6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200305161658.h4GGwicx008647@turing-police.cc.vt.edu>
References: <20030516015407.2768b570.akpm@digeo.com>
	 <20030516100432.GA21627@outpost.ds9a.nl>
	 <1053099462.5599.1.camel@dhcp22.swansea.linux.org.uk>
	 <200305161658.h4GGwicx008647@turing-police.cc.vt.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053179161.7496.27.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 May 2003 14:46:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-05-16 at 17:58, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 16 May 2003 16:37:43 BST, Alan Cox said:
> > All of this stuff should be disablable and far more. It probably all
> > wants hiding under a single "Shrink feature set" type option most people
> > can skip over as they do with kernel debugging.
> 
> No, this sort of thing should be in the .config file, but NOT accessible
> via the point-and-drool interface.  Make them vi it and do it the hard way...

Good idea. We should just have the configuration for *MY* PC and delete
the rest, everything else causes _me_ inconvenience and clearly I'm all
that counts.


