Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWIGQL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWIGQL4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 12:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWIGQL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 12:11:56 -0400
Received: from aa002msr.fastwebnet.it ([85.18.95.65]:18925 "EHLO
	aa002msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932231AbWIGQL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 12:11:56 -0400
Date: Thu, 7 Sep 2006 18:10:53 +0200
From: Mattia Dongili <malattia@linux.it>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: JFS - real deadlock and lockdep warning (2.6.18-rc5-mm1)
Message-ID: <20060907161053.GE13103@inferi.kami.home>
Mail-Followup-To: Dave Kleikamp <shaggy@austin.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	akpm@osdl.org
References: <20060905203309.GA3981@inferi.kami.home> <1157580028.8200.72.camel@kleikamp.austin.ibm.com> <20060907153951.GB13103@inferi.kami.home> <1157643997.23883.4.camel@kleikamp.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157643997.23883.4.camel@kleikamp.austin.ibm.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.18-rc5-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 10:46:36AM -0500, Dave Kleikamp wrote:
> On Thu, 2006-09-07 at 17:39 +0200, Mattia Dongili wrote:
[...]
> > one more spare partition where I can move /home.
> 
> As long as you're going to try a different /home partition, why don't
> you format it as something other than jfs.  This way if you see the

yeah, of course ;)
Thanks
-- 
mattia
:wq!
