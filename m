Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWCZSqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWCZSqs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 13:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWCZSqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 13:46:48 -0500
Received: from mail.charite.de ([160.45.207.131]:46485 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1751119AbWCZSqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 13:46:47 -0500
Date: Sun, 26 Mar 2006 20:46:44 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs/direct-io.c:916!
Message-ID: <20060326184644.GC4776@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060326180440.GA4776@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060326180440.GA4776@charite.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:
> Today I wanted to run xfs_fsr on my laptop. I got:

It's a 2.6.16-mm1 issue, since 2.6.16-git11 does not exhibit that
failure.

> # uname -a
> Linux knarzkiste 2.6.16-mm1 #1 PREEMPT Fri Mar 24 19:01:24 CET 2006  i686 GNU/Linux

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
