Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWJBPVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWJBPVO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 11:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWJBPVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 11:21:14 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:3272 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964778AbWJBPVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 11:21:13 -0400
Subject: Re: Spam, bogofilter, etc
From: Lee Revell <rlrevell@joe-job.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061002100302.GS16047@mea-ext.zmailer.org>
References: <1159539793.7086.91.camel@mindpipe>
	 <20061002100302.GS16047@mea-ext.zmailer.org>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 11:21:25 -0400
Message-Id: <1159802486.4067.140.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 13:03 +0300, Matti Aarnio wrote:
> I do think that Markov Chains combined with Bayes Statistics 
> might do a wee bit better.  (Except with very short emails.)
> However all that these things are able to do is essentially
> grow the key database when spammers are producing new mutated
> (mis-spelled) texts by mixing in spaces, punctuations, and even
> occasional characters.
> 
> For recognizing those pill merchants one needs complex software
> to read the site at the URL, and to read texts out of the IMAGES
> at the site.  Captcha to get thru spam filters...
> 

Could a heuristic be added to reject messages with wildly incorrect
dates?  I notice that the last 5-10 messages in my LKML folder every
morning are spam with a date that's ~24 hours in the future.

Lee

