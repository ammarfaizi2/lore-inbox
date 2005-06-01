Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVFAWNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVFAWNp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 18:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVFAWNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 18:13:11 -0400
Received: from [203.171.93.254] ([203.171.93.254]:8321 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261286AbVFAWMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 18:12:19 -0400
Subject: Re: Freezer Patches.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1117663357.19020.70.camel@gaston>
References: <1117629212.10328.26.camel@localhost>
	 <20050601130205.GA1940@openzaurus.ucw.cz>
	 <1117663357.19020.70.camel@gaston>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1117664017.13830.36.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 02 Jun 2005 08:13:37 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-06-02 at 08:02, Benjamin Herrenschmidt wrote:
> On Wed, 2005-06-01 at 15:02 +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > Here are the freezer patches. They were prepared against rc3, but I
> > > think they still apply fine against rc5. (Ben, these are the same ones I
> > > sent you the other day).
> 
> > 300: stopping softirqd seems dangerous to me... are you sure?
> 
> That sounds bogus indeed.

Ok. Bogus but harmless. I'll try removing it.

Regards,

Nigel

