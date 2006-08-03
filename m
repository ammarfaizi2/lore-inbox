Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWHCSVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWHCSVZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 14:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWHCSVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 14:21:24 -0400
Received: from iron.pdx.net ([207.149.241.18]:6823 "EHLO iron.pdx.net")
	by vger.kernel.org with ESMTP id S964816AbWHCSVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 14:21:24 -0400
Subject: Re: sk98lin extremely slow transfer rate ASUS P5P800(2.6.17.7)
From: Sean Bruno <sean.bruno@dsl-only.net>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1154624306.6485.19.camel@home-desk>
References: <1154619601.6485.15.camel@home-desk>
	 <20060803094009.5f027226@localhost.localdomain>
	 <1154623596.6485.17.camel@home-desk>
	 <20060803095012.237afddb@localhost.localdomain>
	 <1154624306.6485.19.camel@home-desk>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 11:21:17 -0700
Message-Id: <1154629277.6485.21.camel@home-desk>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 09:58 -0700, Sean Bruno wrote:
> On Thu, 2006-08-03 at 09:50 -0700, Stephen Hemminger wrote:
> > e
> ty
> 
> I have built skge and loaded it in leu of sk98lin and re-running my
> failure case.
> 
> sean
> 
> -
Thanks for the guidance.  Simply using the skge driver instead has
resolved the issue I was seeing.

Sean

