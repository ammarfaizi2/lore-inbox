Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWAUIwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWAUIwk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 03:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWAUIwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 03:52:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54988 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751135AbWAUIwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 03:52:39 -0500
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Davej@redhat.com, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, Badari Pulavarty <pbadari@us.ibm.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
In-Reply-To: <20060118194103.5c569040.akpm@osdl.org>
References: <20060119030251.GG19398@stusta.de>
	 <20060118194103.5c569040.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 21 Jan 2006 09:52:27 +0100
Message-Id: <1137833547.2978.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 19:41 -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > Let's do the scheduled removal of the obsolete raw driver in 2.6.17.
> > 
> 
> heh.  I was just thinking that I hadn't heard from Badari and Ken in a while.
> 
> I doubt if this'll fly.  We're stuck with it.

One thing we can do is ask the distributions to stop shipping raw first,
to see what the fallout is (and to give it as a sign that it's an
obsolete interface). Then a  year or two after that....

