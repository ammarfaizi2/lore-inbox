Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbWFTIOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWFTIOG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWFTIOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:14:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:59264 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965009AbWFTIOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:14:05 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilities
Date: Tue, 20 Jun 2006 10:13:51 +0200
User-Agent: KMail/1.9.3
Cc: Jeff Garzik <jeff@garzik.org>, Dave Olson <olson@unixfolk.com>,
       Brice Goglin <brice@myri.com>, linux-kernel@vger.kernel.org,
       Greg Lindahl <greg.lindahl@qlogic.com>, gregkh@suse.de
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no> <200606200925.30926.ak@suse.de> <4497ABAC.4030305@garzik.org>
In-Reply-To: <4497ABAC.4030305@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606201013.51564.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 June 2006 10:02, Jeff Garzik wrote:
> Andi Kleen wrote:
> > So if there are any more MSI problems comming up IMHO it should be white list/disabled 
> > by default and only turn on after a long time when Windows uses it by default 
> > or something. Greg, do you agree?
> 
> 
> We should be optimists, not pessimists.

Yes, booting on all systems is overrated anyways, isn't it?

> 
> MSI is useful enough that we should turn it on by default in newer systems.

That is what we've tried so far and it seems to not work.

-Andi
