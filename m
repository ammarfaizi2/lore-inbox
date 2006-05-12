Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWELPb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWELPb4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 11:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWELPb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:31:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:43977 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932141AbWELPbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:31:55 -0400
X-Authenticated: #14349625
Subject: Re: swapping and oom-killer: gfp_mask=0x201d2, order=0
From: Mike Galbraith <efault@gmx.de>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200605121517.59988.a1426z@gawab.com>
References: <200605111514.45503.a1426z@gawab.com>
	 <1147412910.8432.14.camel@homer>  <200605121517.59988.a1426z@gawab.com>
Content-Type: text/plain
Date: Fri, 12 May 2006 17:31:53 +0200
Message-Id: <1147447913.7520.6.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-12 at 15:17 +0300, Al Boldi wrote:
> Note that this is not specific to mem=8M, but rather a general oom 
> observation even for mem=4G, where it is only much later to occur.

An oom situation with 4G ram would be more interesting than this one.

	-Mike



