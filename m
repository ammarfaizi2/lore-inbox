Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264100AbTJOUtD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 16:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264102AbTJOUtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 16:49:03 -0400
Received: from cpc1-cwma1-5-0-cust4.swan.cable.ntl.com ([80.5.120.4]:45215
	"EHLO dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264100AbTJOUtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 16:49:01 -0400
Subject: Re: PRD Table
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: id ol <idol4232003@yahoo.com>
Cc: Andre Hedrick <andre@linux-ide.org>, vatsa@in.ibm.com,
       lkcd-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
In-Reply-To: <20031013174101.52992.qmail@web10003.mail.yahoo.com>
References: <20031013174101.52992.qmail@web10003.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1066250777.3268.15.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2) 
Date: Wed, 15 Oct 2003 21:46:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-10-13 at 18:41, id ol wrote:
> Hi all,
> 
> I am running into some possible DMA-related problems
> with my system.  I am wondering, what is the easiest
> way to make the PRD Table region uncacheable?  I
> appreciate any tips that will point me in the right
> direction.

Hardware specific question. It depends on your platform.

