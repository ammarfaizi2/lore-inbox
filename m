Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265125AbUFARLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbUFARLH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 13:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265130AbUFARLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 13:11:06 -0400
Received: from 209-128-98-078.bayarea.net ([209.128.98.78]:22145 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S265125AbUFARKd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 13:10:33 -0400
Message-ID: <40BCB864.7000308@zytor.com>
Date: Tue, 01 Jun 2004 10:09:56 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.6-rc3] gcc-3.4.0 fixes
References: <200404292146.i3TLkfI0019612@harpo.it.uu.se>	<c892nk$5pf$1@terminus.zytor.com> <16572.38987.239160.819836@alkaid.it.uu.se>
In-Reply-To: <16572.38987.239160.819836@alkaid.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> 
> You're assuming pointers have uniform representation.
> C makes no such guarantees, and machines _have_ had
> different types of representations in the past.
 >

And are there *any* such architectures for which gcc are targetted.  I'm not 
advocating advancing this to the C standard, I'm advocating not removing an 
extension which has been documented for a decade.

	-hpa
