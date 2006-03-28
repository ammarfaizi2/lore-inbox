Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWC1Far@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWC1Far (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 00:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWC1Faq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 00:30:46 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:55180 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751304AbWC1Faq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 00:30:46 -0500
Subject: Re: [RFC] Virtualization steps
From: Sam Vilain <sam@vilain.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4428BB5C.3060803@tmr.com>
References: <44242A3F.1010307@sw.ru>  <44242D4D.40702@yahoo.com.au>
	 <1143228339.19152.91.camel@localhost.localdomain>
	 <4428BB5C.3060803@tmr.com>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 17:31:01 +1200
Message-Id: <1143523861.7156.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-27 at 23:28 -0500, Bill Davidsen wrote:
> Frankly I don't see running 100 VMs as a realistic goal, being able to 
> run Linux, Windows, Solaris and BEOS unmodified in 4-5 VMs would be far 
> more useful.

You misunderstand this approach.  It is not about VMs at all.  Any VM
approach is the "big hammer" of virtualisation; we are more interested
in a big bag of very precise tools to virtualise one subsystem at a
time.

Sam.

