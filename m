Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270858AbTG0QaM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 12:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270859AbTG0QaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 12:30:11 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62085
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270858AbTG0QaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 12:30:09 -0400
Subject: Re: time for some drivers to be removed?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David D. Hagood" <wowbagger@sktc.net>
Cc: Adrian Bunk <bunk@fs.tum.de>, "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F23F6EB.7070502@sktc.net>
References: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain>
	 <20030727153118.GP22218@fs.tum.de>  <3F23F6EB.7070502@sktc.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059324018.13442.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Jul 2003 17:40:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-27 at 16:59, David D. Hagood wrote:
> This is a pet peeve of mine on Free Software projects in general - The 
> Program That Wouldn't Compile.
> 
> It would seem to me that in the context of the kernel, what is needed is 
> a BROKEN flag.

We've had one for years. Its CONFIG_OBSOLETE, its even used in 2.6test

