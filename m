Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbUKSVf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbUKSVf1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 16:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbUKSVf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:35:26 -0500
Received: from gold.pobox.com ([208.210.124.73]:25314 "EHLO gold.pobox.com")
	by vger.kernel.org with ESMTP id S261575AbUKSVef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:34:35 -0500
Date: Fri, 19 Nov 2004 13:34:23 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Massimo Cetra <mcetra@navynet.it>
Cc: "'Barry K. Nathan'" <barryn@pobox.com>, "'O.Sezer'" <sezeroz@ttnet.net.tr>,
       linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: Linux 2.4.28-rc4
Message-ID: <20041119213423.GA11601@ip68-4-98-123.oc.oc.cox.net>
References: <20041118204841.GA11682@ip68-4-98-123.oc.oc.cox.net> <20041119001033.B25D48400A@server1.navynet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119001033.B25D48400A@server1.navynet.it>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 01:10:32AM +0100, Massimo Cetra wrote:
> Why such a decision ?
> 
> Do you think that it is not exploitable or at least not in a short time ?

As far as I can tell, the only damage an exploit could do is to crash
*itself*; unless I'm mistaken, any "exploit" would not be able to use
either of these bugs to do any other mischief. I guess that's a long way
of saying, I don't think it's exploitable.

-Barry K. Nathan <barryn@pobox.com>

