Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVCJISw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVCJISw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 03:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbVCJISN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 03:18:13 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:49110 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262403AbVCJIQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 03:16:36 -0500
Date: Thu, 10 Mar 2005 00:16:34 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Jason Luo <abcd.bpmf@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can I get 200M contiguous physical memory?
Message-ID: <20050310081634.GA29516@taniwha.stupidest.org>
References: <c4b38ec4050310001061c62b9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4b38ec4050310001061c62b9d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 04:10:18PM +0800, Jason Luo wrote:

> Now, I am writing a driver, which need 200M contiguous physical
> memory? can do? how to do it?

Not easily no.  Do you really need this?  What kind of hardware is
this?
