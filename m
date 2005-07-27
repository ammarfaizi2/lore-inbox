Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVG0LMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVG0LMY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 07:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVG0LMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 07:12:23 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:52118 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262188AbVG0LLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 07:11:51 -0400
Subject: Re: Question re the dot releases such as 2.6.12.3
From: Steven Rostedt <rostedt@goodmis.org>
To: Valdis.Kletnieks@vt.edu
Cc: Kurt Wall <kwall@kurtwerks.com>, webmaster@kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200507270234.j6R2YEW4009061@turing-police.cc.vt.edu>
References: <200507251020.08894.gene.heskett@verizon.net>
	 <42E51593.7070902@didntduck.org> <20050727012853.GA2354@kurtwerks.com>
	 <1122429050.29823.44.camel@localhost.localdomain>
	 <200507270234.j6R2YEW4009061@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 27 Jul 2005 07:11:43 -0400
Message-Id: <1122462703.29823.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-26 at 22:34 -0400, Valdis.Kletnieks@vt.edu wrote:
> 
> Even more to the point - when 2.6.13 comes out, there will be a patch against
> 2.6.12, not 2.6.12.N, which means you get to download the 2.6.12.N tarball,
> the 2.6.12.N patch, patch -R that, and *then* apply the 2.6.13 patch.

The sad part of this, is that I have actually done that :-/ (when 2.6.12
came out s/\.12/.11/ s/\.13/.12/).

-- Steve

