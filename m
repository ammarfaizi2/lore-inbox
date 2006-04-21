Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWDUJvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWDUJvd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 05:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWDUJvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 05:51:32 -0400
Received: from smtp13.wanadoo.fr ([193.252.22.54]:11904 "EHLO
	smtp13.wanadoo.fr") by vger.kernel.org with ESMTP id S1751310AbWDUJvb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 05:51:31 -0400
X-ME-UUID: 20060421095129792.C1884700008E@mwinf1312.wanadoo.fr
Date: Fri, 21 Apr 2006 11:50:28 +0200
From: Mathieu Chouquet-Stringer <mchouque@free.fr>
To: Bob Tracy <rct@gherkin.frus.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
       rth@twiddle.net
Subject: Re: strncpy (maybe others) broken on Alpha
Message-ID: <20060421095028.GA8818@bigip.bigip.mine.nu>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@free.fr>,
	Bob Tracy <rct@gherkin.frus.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	rth@twiddle.net
References: <20060420215723.GA3949@bigip.bigip.mine.nu> <20060421024304.2D851DBA1@gherkin.frus.com> <20060421081500.GA3767@bigip.bigip.mine.nu> <20060421092127.GA7382@bigip.bigip.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421092127.GA7382@bigip.bigip.mine.nu>
User-Agent: Mutt/1.4.2.1i
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 11:21:27AM +0200, Mathieu Chouquet-Stringer wrote:
> The bad news is my test case, compiled with a native gcc version 3.4.4
> and binutils version 2.16.1 doesn't work as expected.  So maybe it's
> combination of gcc/binutils?  I'm booting the new kernel just to confirm
> that 3.4.4 and 2.16.1 do not work.

A native gcc 3.4.4 and binutils 2.16.1 do not work...  What should we
try next?

-- 
Mathieu Chouquet-Stringer                           mchouque@free.fr

