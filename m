Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbWFTK5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbWFTK5M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 06:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbWFTK5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 06:57:12 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:37070
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932561AbWFTK5L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 06:57:11 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Chris Wright <chrisw@sous-sol.org>, linville@tuxdriver.com
Subject: Re: Linux 2.6.17.1
Date: Tue, 20 Jun 2006 12:56:26 +0200
User-Agent: KMail/1.9.1
References: <20060620101350.GE23467@sequoia.sous-sol.org> <200606201235.19811.mb@bu3sch.de> <20060620104416.GG23467@sequoia.sous-sol.org>
In-Reply-To: <20060620104416.GG23467@sequoia.sous-sol.org>
Cc: stable@kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606201256.27252.mb@bu3sch.de>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 June 2006 12:44, Chris Wright wrote:
> * Michael Buesch (mb@bu3sch.de) wrote:
> > On Tuesday 20 June 2006 12:13, Chris Wright wrote:
> > > We (the -stable team) are announcing the release of the 2.6.17.1 kernel.
> > 
> > Please consider inclusion of the following patch into 2.6.17.2:
> > 
> > It fixes a possible crash. Might be triggerable in networks with
> > heavy traffic. I only saw it once so far, though.
> 
> I didn't notice that it made it to Linus' tree yet.  Can you make sure
> to push it up, and I'll queue it for -stable.

It is in -mm and I think John Linville also queued it upstream
through Jeff to Linus.
>From my perspective, everything is done ;)

-- 
Greetings Michael.
