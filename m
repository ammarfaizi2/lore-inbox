Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263322AbVCKCrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbVCKCrC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 21:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbVCKCq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 21:46:59 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:62426 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S263322AbVCKCnF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 21:43:05 -0500
Date: Thu, 10 Mar 2005 21:43:28 -0500
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] -stable, how it's going to work.
Message-ID: <20050311024328.GA17700@fieldses.org>
References: <20050309072833.GA18878@kroah.com> <16944.6867.858907.990990@cse.unsw.edu.au> <20050310164312.GC16126@kroah.com> <16944.57853.539416.268893@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16944.57853.539416.268893@cse.unsw.edu.au>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 11:10:37AM +1100, Neil Brown wrote:
> I didn't mean "If it fixes a regression, it should be accepted."
> I meant "If it does not fix a regression, it should not be accepted."

... Presumably with the obvious exception for security fixes.--b.
