Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbTIRMLK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 08:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbTIRMLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 08:11:10 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:63660 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261206AbTIRMLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 08:11:07 -0400
Subject: Re: [PATCH] Altix console driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesse Barnes <jbarnes@sgi.com>, pfg@sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030917152139.42a1ce20.akpm@osdl.org>
References: <20030917222414.GA25931@sgi.com>
	 <20030917152139.42a1ce20.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063886970.15957.13.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Thu, 18 Sep 2003 13:09:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-17 at 23:21, Andrew Morton wrote:

> Would it be more appropriate to place this under arch/ia64?

Unless they clarify the GPL violating license clause I'd suggest
strongly it goes into /dev/null. The GPL states:


  6. Each time you redistribute the Program (or any work based on the
Program), the recipient automatically receives a license from the
original licensor to copy, distribute or modify the Program subject to
these terms and conditions.  You may not impose any further
restrictions on the recipients' exercise of the rights granted herein.
You are not responsible for enforcing compliance by third parties to
this License.

I am perfectly permitted by the GPL to modify Linux and add other code
to it, or to create a new product based on it that is GPL licensed. 


SGI need to fix their boilerplate. I can kind of guess what they are
trying to say but it needs tweaking.

