Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVEZN6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVEZN6d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 09:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVEZN6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 09:58:33 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:4526 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261471AbVEZN6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 09:58:20 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc1-mm2
Date: Thu, 26 May 2005 15:58:21 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, rlrevell@joe-job.com,
       alsa-devel@lists.sourceforge.net
References: <20050324044114.5aa5b166.akpm@osdl.org> <200503242331.46985.rjw@sisk.pl> <20050525172949.0d5e637c.akpm@osdl.org>
In-Reply-To: <20050525172949.0d5e637c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505261558.22267.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 26 of May 2005 02:29, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > 
> > BTW, on 2.6.12-rc1-mm2 I can't rmmod the snd_intel8x0 module (the process
> > goes into the D state immediately), which did not happen before.  This is 100%
> > reproducible, on two different AMD64-based boxes, with different sound chips.
> 
> Is this bug stil present in 2.6.12-rc5-mm1 or 2.6.12-rc5?

It's gone. :-)

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
