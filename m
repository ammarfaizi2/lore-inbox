Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWCHTfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWCHTfe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 14:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWCHTfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 14:35:34 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:60677 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S932130AbWCHTfd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 14:35:33 -0500
Date: Wed, 8 Mar 2006 19:34:33 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: de2104x: interrupts before interrupt handler is registered
Message-ID: <20060308193433.GA7611@unjust.cyrius.com>
References: <5N5Ql-30C-11@gated-at.bofh.it> <200603071051.35791.bjorn.helgaas@hp.com> <4807377b0603080018h1b952e3av4966d81b85f6d346@mail.gmail.com> <200603080905.59470.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603080905.59470.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bjorn Helgaas <bjorn.helgaas@hp.com> [2006-03-08 09:05]:
> Booting with "pci=routeirq" gives the previous behavior.
> 
> It would be interesting to know whether that makes a difference
> in the e100 issue you mention.

FWIW, I'm pretty sure I tried this with de2104x and it didn't help.
I'm not positive though, but I could test again if people are
interested in the result.
-- 
Martin Michlmayr
tbm@cyrius.com
