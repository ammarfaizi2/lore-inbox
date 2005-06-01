Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVFAWZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVFAWZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 18:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVFAWZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 18:25:28 -0400
Received: from gate.crashing.org ([63.228.1.57]:29125 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261345AbVFAWYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 18:24:02 -0400
Subject: Re: Freezer Patches.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ncunningham@cyclades.com
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1117664017.13830.36.camel@localhost>
References: <1117629212.10328.26.camel@localhost>
	 <20050601130205.GA1940@openzaurus.ucw.cz>
	 <1117663357.19020.70.camel@gaston>  <1117664017.13830.36.camel@localhost>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 08:23:42 +1000
Message-Id: <1117664622.19020.77.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-02 at 08:13 +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Thu, 2005-06-02 at 08:02, Benjamin Herrenschmidt wrote:
> > On Wed, 2005-06-01 at 15:02 +0200, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > Here are the freezer patches. They were prepared against rc3, but I
> > > > think they still apply fine against rc5. (Ben, these are the same ones I
> > > > sent you the other day).
> > 
> > > 300: stopping softirqd seems dangerous to me... are you sure?
> > 
> > That sounds bogus indeed.
> 
> Ok. Bogus but harmless. I'll try removing it.

Not really harmless, you happen to be lucky :)

Ben.
 

