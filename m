Return-Path: <linux-kernel-owner+w=401wt.eu-S1761829AbWLITCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761829AbWLITCA (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 14:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761831AbWLITB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 14:01:59 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:33783 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761828AbWLITB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 14:01:59 -0500
Date: Sat, 9 Dec 2006 10:58:56 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Ian Kent <raven@themaw.net>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, torvalds@osdl.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jkosina@suse.cz
Subject: Re: [patch 28/32] autofs: fix error code path in autofs_fill_sb()
Message-ID: <20061209185856.GU1397@sequoia.sous-sol.org>
References: <20061208235751.890503000@sous-sol.org> <20061209000246.210981000@sous-sol.org> <1165636126.3980.11.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165636126.3980.11.camel@raven.themaw.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ian Kent (raven@themaw.net) wrote:
> On Fri, 2006-12-08 at 15:58 -0800, Chris Wright wrote:
> > plain text document attachment
> > (autofs-fix-error-code-path-in-autofs_fill_sb.patch)
> > -stable review patch.  If anyone has any objections, please let us know.
> > ------------------
> 
> Stable review of what (version)?

This is for 2.6.19

thanks,
-chris
