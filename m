Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVFAWEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVFAWEe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 18:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVFAWEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 18:04:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:11973 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261319AbVFAWDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 18:03:01 -0400
Subject: Re: Freezer Patches.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050601130205.GA1940@openzaurus.ucw.cz>
References: <1117629212.10328.26.camel@localhost>
	 <20050601130205.GA1940@openzaurus.ucw.cz>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 08:02:36 +1000
Message-Id: <1117663357.19020.70.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-01 at 15:02 +0200, Pavel Machek wrote:
> Hi!
> 
> > Here are the freezer patches. They were prepared against rc3, but I
> > think they still apply fine against rc5. (Ben, these are the same ones I
> > sent you the other day).

> 300: stopping softirqd seems dangerous to me... are you sure?

That sounds bogus indeed.



