Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265493AbTFMTTA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 15:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbTFMTS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 15:18:59 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:2835 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id S265493AbTFMTS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 15:18:59 -0400
Date: Fri, 13 Jun 2003 13:32:40 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: James Bourne <jbourne@hardrock.org>, "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-uv1 patch released
Message-ID: <15860000.1055532759@caspian.scsiguy.com>
In-Reply-To: <Pine.LNX.4.44.0306131246020.9166-100000@cafe.hardrock.org>
References: <Pine.LNX.4.44.0306131246020.9166-100000@cafe.hardrock.org>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 13 Jun 2003, Randy.Dunlap wrote:
> 
>> I can't boot 2.4.21 without the latest aic7xyz tarball applied,
>> from http://people.FreeBSD.org/~gibbs/linux/SRC/
>> 
>> The 2.4.21 driver just hangs during boot.
> 
> Nifty...
> 
> Justin, is this a confirmed problem with the aic79xx driver in 2.4.21 and is
> there a 2.4.21-rc8 or later patch that will go in clean?  (I'm thinking the
> 2.4-20030603 patch should).

The BK send file for 2.4.X should go in clean and since it includes
all of the revision history is much preferable to any patch.

--
Justin

