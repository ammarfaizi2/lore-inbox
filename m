Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVFNOpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVFNOpN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 10:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVFNOpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 10:45:04 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:9612 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261253AbVFNOff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 10:35:35 -0400
Date: Tue, 14 Jun 2005 20:03:05 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] files: fix rcu initializers
Message-ID: <20050614143305.GH4557@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050614142612.GA4557@in.ibm.com> <20050614142735.GB4557@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050614142735.GB4557@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 07:57:35PM +0530, Dipankar Sarma wrote:
> 
> 
> RCU head initilizer no longer needs the head varible name since
> we don't use list.h lists anymore. 
> 
> Signed-off-by : Dipankar Sarma <dipankar@in.ibm.com>
> 

Dang. Should be 1 of 6. Sorry.

Dipankar
