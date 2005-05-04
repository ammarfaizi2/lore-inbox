Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVEDWLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVEDWLb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 18:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVEDWLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 18:11:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:43939 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261801AbVEDWLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 18:11:25 -0400
Date: Wed, 4 May 2005 15:11:22 -0700
From: Chris Wright <chrisw@osdl.org>
To: Eric Cooper <ecc@cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: repeatable mm/rmap.c crash in 2.6.11.*
Message-ID: <20050504221122.GU23013@shell0.pdx.osdl.net>
References: <20050504215311.GA28900@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050504215311.GA28900@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Eric Cooper (ecc@cmu.edu) wrote:
> I first noticed this in 2.6.11, and it has been present in each point
> release since then.  This is on a machine that runs 2.6.10 with no
> problems.  I finally got around to capturing the output over a serial
> console, using 2.6.11.8.  It happens on every boot, almost always
> before the init scripts are finished.  Here's one example.  I can
> provide others, or more info, as needed.  Thanks.

This one's been a bit elusive.  If you could apply the patch in the mail
(link) below and let me (or Hugh) know what you find that'd be quite
helpful.

http://marc.theaimsgroup.com/?l=linux-kernel&m=111101533309675&w=2


thanks,
-chris
