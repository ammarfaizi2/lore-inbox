Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263507AbTIHTDe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263508AbTIHTDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:03:34 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:56820 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263507AbTIHTDd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 15:03:33 -0400
Subject: Re: New ATI FireGL driver supports 2.6 kernel
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Dave Jones <davej@redhat.com>
Cc: Stian Jordet <liste@jordet.nu>, Mika Liljeberg <mika.liljeberg@welho.com>,
       linux-kernel@vger.kernel.org, dri-users@lists.sourceforge.net
In-Reply-To: <20030908184117.GA681@redhat.com>
References: <1063044345.1895.10.camel@hades>
	 <1063045080.21991.13.camel@chevrolet.hybel>
	 <20030908184117.GA681@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063047781.22153.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Mon, 08 Sep 2003 21:03:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Comedy. So the story so far..
> 
> - ATI grab 2.4.16's AGP driver.
> - Working AGP3 support happens in 2.5
> - ATI gets backported to 2.4 and 'munged'.
> - Additional fixes go into 2.5
> - ATI forwardport their trainwreck to 2.6.
> 
> It shouldn't have *any* need whatsoever to touch agpgart in 2.6.

isn't the 2.5 AGP GPL licensed? How can ATI then include it in a bin
only module ? ....
