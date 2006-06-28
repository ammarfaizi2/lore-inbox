Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWF1Flo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWF1Flo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWF1Flo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:41:44 -0400
Received: from hera.kernel.org ([140.211.167.34]:57831 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964785AbWF1Fln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:41:43 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux 2.6.16.22
Date: Tue, 27 Jun 2006 22:41:38 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e7t4qi$u26$1@terminus.zytor.com>
References: <20060622201757.GZ22737@sequoia.sous-sol.org> <Pine.LNX.4.63.0606251347100.31427@er-systems.de> <20060627235724.GK11588@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1151473298 30791 127.0.0.1 (28 Jun 2006 05:41:38 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 28 Jun 2006 05:41:38 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20060627235724.GK11588@sequoia.sous-sol.org>
By author:    Chris Wright <chrisw@sous-sol.org>
In newsgroup: linux.dev.kernel
>
> * Thomas Voegtle (tv@lio96.de) wrote:
> > On Thu, 22 Jun 2006, Chris Wright wrote:
> > > We (the -stable team) are announcing the release of the 2.6.16.22 kernel.
> > > The diffstat and short summary of the fixes are below.
> > 
> > Perhaps I missed the discussion about it, but why is this not piped 
> > through linux-kernel-announce?
> 
> I stopped making those announcements separately because the automated
> versions were working well.
> 
> > It isn't on kernel.org as well so it is hard to track it.
> 
> Yeah, that's true, the automated logic that tracks that and generates
> the messages doesn't fit well with multiple -stable versions.
> 

I may be able to fix that, assuming everything else remains constant
(locations of git trees, etc.)

	-hpa

