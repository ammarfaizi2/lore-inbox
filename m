Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWGQTKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWGQTKq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 15:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWGQTKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 15:10:46 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:44165 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751161AbWGQTKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 15:10:45 -0400
Date: Mon, 17 Jul 2006 12:10:42 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Mandy Kirkconnell <alkirkco@sgi.com>, Nathan Scott <nathans@sgi.com>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 01/45] XFS: corruption fix
Message-ID: <20060717191042.GA7942@tuatara.stupidest.org>
References: <20060717160652.408007000@blue.kroah.org> <20060717162518.GB4829@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060717162518.GB4829@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2006 at 09:25:18AM -0700, Greg KH wrote:

> -stable review patch.  If anyone has any objections, please let us know.
>
> ------------------
>
> From: Mandy Kirkconnell <alkirkco@sgi.com>

Unless 2.6.16.x is a dead-end could we please also have this patch put
into there?
