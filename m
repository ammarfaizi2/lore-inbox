Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWBVVNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWBVVNG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 16:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWBVVNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 16:13:06 -0500
Received: from opersys.com ([64.40.108.71]:32530 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1750761AbWBVVNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 16:13:05 -0500
Message-ID: <43FCD735.2030002@opersys.com>
Date: Wed, 22 Feb 2006 16:27:17 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       Paul Mundt <lethal@linux-sh.org>, Tom Zanussi <zanussi@us.ibm.com>,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH, RFC] sysfs: relay channel buffers as sysfs attributes
References: <20060219171748.GA13068@linux-sh.org> <20060219175623.GA2674@kroah.com> <20060219185254.GA13391@linux-sh.org> <17401.21427.568297.830492@tut.ibm.com> <20060220130555.GA29405@Krystal> <20060220171531.GA9381@linux-sh.org> <20060220173732.GA7238@Krystal> <20060221152102.GA20835@linux-sh.org> <20060221164852.GA6489@Krystal> <20060221174318.GB23018@kroah.com>
In-Reply-To: <20060221174318.GB23018@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH wrote:
> And as a debug tool, debugfs seems like the perfict place for it, as you
> have just stated :)

So then the statement is that debugfs is for _ALL_ kinds of debugging,
including application debugging. IOW, anyone considering debugfs as
an fs exclusive to kernel-developers is WRONG. IOW2, distros should
_NOT_ shy away from enabling debugfs by default on their production
kernels.

Right?

Just want to make sure this is clear as it has been my impression
all along (and it seems that of others out there), and I may have
very well been wrong, that debugfs is solely for kernel developers.

Thanks,

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
