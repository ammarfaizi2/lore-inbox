Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266679AbUJFBx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266679AbUJFBx1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 21:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266683AbUJFBx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 21:53:26 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:42661 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S266679AbUJFBxQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 21:53:16 -0400
Date: Tue, 5 Oct 2004 21:53:10 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: crash77a@allvantage.com, linux-kernel@vger.kernel.org
Subject: Re: Converting kernel modules from 2.4 to 2.6/Suggested new driver
Message-ID: <20041006015310.GD9683@fieldses.org>
References: <416345C0.4050500@allvantage.com> <20041005182716.2f3f52c0.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041005182716.2f3f52c0.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 06:27:16PM -0700, Randy.Dunlap wrote:
> You can recommend them for inclusion, but the developer or maintainer
> of them needs to either submit them or at least approve their
> submission for inclusion.

Also, the first thing to check is probably this:

> On Tue, 05 Oct 2004 21:09:20 -0400 Kenny Bentley wrote:
> | Or since I've never done any kernel programming, I have a better idea.  
> | I want to recommend the drivers for inclusion into the official kernel 
> | tree.  The drivers were released open-source by Linuxant or the 
> | manufacturer, I don't remember which one for sure.

You'll need to double-check that.  I think Linuxant released some
free-as-in-beer drivers that were a mixture of free and proprietary
code, so it was easy to get confused on this point.

--Bruce Fields
