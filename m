Return-Path: <linux-kernel-owner+w=401wt.eu-S932498AbWLLWpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWLLWpb (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWLLWpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:45:31 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:3319 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932498AbWLLWpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:45:31 -0500
Date: Tue, 12 Dec 2006 23:45:27 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Andrew Robinson <andrew.rw.robinson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS corruption with 2.6.19 (Was 2.6.19 is not stable with SATA and should not be used by any meansis not stable with SATA and should not be used by any means)
Message-ID: <20061212224527.GA4045@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Andrew Robinson <andrew.rw.robinson@gmail.com>,
	linux-kernel@vger.kernel.org
References: <bc36a6210612121044vf259b34u4ec3cac4df56e43c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc36a6210612121044vf259b34u4ec3cac4df56e43c@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 11:44:18AM -0700, Andrew Robinson wrote:
> When I said hibernate, I did mention it was to disk, not to ram.

Suspend to disk is not trustable on Linux, and does not look like it
will be any time soon.  Suspend to ram has a better chance of becoming
reliable, but at that point is not ide/sata compatible, and X will
keep making things hard.

  OG.
