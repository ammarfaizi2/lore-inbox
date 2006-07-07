Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWGGGqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWGGGqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 02:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWGGGqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 02:46:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15269 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751205AbWGGGqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 02:46:24 -0400
Date: Fri, 7 Jul 2006 02:46:10 -0400
From: Dave Jones <davej@redhat.com>
To: Bret Towe <magnade@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1 bttv modprobe null pointer dereference
Message-ID: <20060707064610.GA27347@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Bret Towe <magnade@gmail.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <dda83e780607062051x220841c7ya88ff0aefd5d3071@mail.gmail.com> <20060706215225.290360bf.akpm@osdl.org> <dda83e780607062219q1db55c58ga7eb1d5438635dcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda83e780607062219q1db55c58ga7eb1d5438635dcc@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 10:19:09PM -0700, Bret Towe wrote:
 > ill be recompiling without it and seeing if anything looks odd
 > and the mce i think has always been there as i recall seeing it
 > when i did previous bug reports

If you're getting recurring machine checks, that smells strongly
like a hardware problem.  Have you tried running memtest on
this box ?

		Dave

-- 
http://www.codemonkey.org.uk
