Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268300AbUHKWqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268300AbUHKWqq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 18:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268297AbUHKWob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:44:31 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:4260 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S268292AbUHKWnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:43:22 -0400
Subject: Re: ipw2100 wireless driver
From: David Woodhouse <postmaster@infradead.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040811175109.GJ10100@louise.pinerecords.com>
References: <4119F203.1070009@linux.intel.com>
	 <20040811114437.A27439@infradead.org> <411A478E.1080101@linux.intel.com>
	 <20040811093043.522cc5a0@dell_ss3.pdx.osdl.net>
	 <20040811163333.GE10100@louise.pinerecords.com>
	 <20040811175105.A30188@infradead.org>
	 <20040811170208.GG10100@louise.pinerecords.com>
	 <20040811181142.A30309@infradead.org>
	 <20040811172222.GI10100@louise.pinerecords.com>
	 <20040811184148.A30660@infradead.org>
	 <20040811175109.GJ10100@louise.pinerecords.com>
Content-Type: text/plain
Message-Id: <1092264200.1438.4347.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 11 Aug 2004 23:43:20 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-11 at 19:51 +0200, Tomas Szepe wrote:
> 550-Verification failed for <szepe@pinerecords.com>
> 550-(result of earlier verification reused).
> 550 Sender verify failed
> 
> I for one don't call this a properly configured mail system.

Indeed it isn't. It doesn't accept mail to 'postmaster@pinerecords.com',
which is in violation of RFC2821. Hence we don't accept mail from it.

2004-08-11 17:33:36 H=louise.pinerecords.com [213.168.176.16] sender
verify fail for <kala@pinerecords.com>: response to "RCPT
TO:<postmaster@pinerecords.com>" from louise.pinerecords.com
[213.168.176.16] was: 553 5.3.0 <postmaster@pinerecords.com>... No such
user

2004-08-11 17:33:36 H=louise.pinerecords.com [213.168.176.16]
F=<kala@pinerecords.com> rejected RCPT <hch@infradead.org>: Sender
verify failed

-- 
dwmw2


