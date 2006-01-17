Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWAQGjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWAQGjf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 01:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWAQGjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 01:39:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22423 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751081AbWAQGje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 01:39:34 -0500
Date: Tue, 17 Jan 2006 01:39:19 -0500
From: Dave Jones <davej@redhat.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: Re: [patch 2.6.15-current] i386: multi-column stack backtraces
Message-ID: <20060117063919.GA25018@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Akinobu Mita <mita@miraclelinux.com>
References: <200601170126_MC3-1-B602-EFCB@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601170126_MC3-1-B602-EFCB@compuserve.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 01:23:26AM -0500, Chuck Ebbert wrote:
 > Print stack backtraces in multiple columns, saving screen space.
 > Number of columns is configurable and defaults to one so 
 > behavior is backwards-compatible.

The CONFIG option seems redundant to me, but..

Signed-off-by: Dave Jones <davej@redhat.com>

		Dave

