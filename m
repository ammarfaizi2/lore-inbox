Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161567AbWJKWTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161567AbWJKWTP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 18:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161568AbWJKWTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 18:19:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42431 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161561AbWJKWTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 18:19:10 -0400
Date: Wed, 11 Oct 2006 18:17:52 -0400
From: Dave Jones <davej@redhat.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 00/67] 2.6.18-stable review
Message-ID: <20061011221752.GA2248@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	Justin Forbes <jmforbes@linuxtx.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
	Chuck Wolber <chuckw@quantumlinux.com>,
	Chris Wedgwood <reviews@ml.cw.f00f.org>,
	Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org,
	akpm@osdl.org, alan@lxorguk.ukuu.org.uk
References: <20061011210310.GA16627@kroah.com> <20061011213648.GC32371@redhat.com> <20061011215943.GA19559@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011215943.GA19559@suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 02:59:43PM -0700, Greg KH wrote:
 
 > Hm, I guess the dontdiff file wasn't updated, as I built and booted out
 > of that directory, so that is where it came from.  Sorry about that.
 > 
 > Anyone want to update dontdiff?  :)
 
Hmm..

(18:17:33:davej@nwo:local-git)$ grep utsrelease Documentation/dontdiff
utsrelease.h*
(18:17:37:davej@nwo:local-git)$ 

Shouldn't that match ?

	Dave

-- 
http://www.codemonkey.org.uk
