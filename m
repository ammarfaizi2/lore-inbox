Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264163AbTIIRCA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 13:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264172AbTIIRCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 13:02:00 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:14470 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264163AbTIIRB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 13:01:59 -0400
Subject: Re: Hot Swapping IDE using USB2 cage
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: keithl@ieee.org
Cc: Mark Watts <m.watts@eris.qinetiq.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030909163347.GA2882@gate.kl-ic.com>
References: <20030908193207.GA29053@gate.kl-ic.com>
	 <200309091601.01731.m.watts@eris.qinetiq.com>
	 <20030909163347.GA2882@gate.kl-ic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063126821.30379.63.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Tue, 09 Sep 2003 18:00:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-09-09 at 17:33, Keith Lofstrom wrote:
> it is more expensive than a hypothetical, purely IDE solution. 
> However, a pure solution is not now available, and the pursuit
> of that may be a distraction from other pressing issues.  

The IDE solution isnt hypothetical any more, its in 2.4.23-pre 
at least for some chipsets and adding more isnt too hard

