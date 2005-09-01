Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbVIANTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbVIANTZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 09:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbVIANTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 09:19:24 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:24013 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S965087AbVIANTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 09:19:24 -0400
Date: Thu, 1 Sep 2005 15:19:15 +0200
From: David Weinehall <tao@acc.umu.se>
To: Tony Lindgren <tony@atomide.com>
Cc: Con Kolivas <kernel@kolivas.org>, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       s0348365@sms.ed.ac.uk, tytso@mit.edu, cfriesen@nortel.com,
       rlrevell@joe-job.com, trenn@suse.de, george@mvista.com,
       johnstul@us.ibm.com, akpm@osdl.org
Subject: Re: Updated dynamic tick patches
Message-ID: <20050901131915.GL5011@khan.acc.umu.se>
Mail-Followup-To: Tony Lindgren <tony@atomide.com>,
	Con Kolivas <kernel@kolivas.org>, vatsa@in.ibm.com,
	linux-kernel@vger.kernel.org, arjan@infradead.org,
	s0348365@sms.ed.ac.uk, tytso@mit.edu, cfriesen@nortel.com,
	rlrevell@joe-job.com, trenn@suse.de, george@mvista.com,
	johnstul@us.ibm.com, akpm@osdl.org
References: <20050831165843.GA4974@in.ibm.com> <200509011523.13994.kernel@kolivas.org> <20050901130721.GB10677@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901130721.GB10677@atomide.com>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 04:07:22PM +0300, Tony Lindgren wrote:
[snip]
> I tried this quickly on a loaner ThinkPad T30, and needed the following
> patch to compile. The patch does work with PIT, but with lapic the
> system does not wake to timer interrupts :(

That may be a thinkpad issue; I have to boot my Thinkpad with nolapic.

[snip]


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
