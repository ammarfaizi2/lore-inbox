Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbTEIQ5q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 12:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263332AbTEIQ5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 12:57:45 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:63472 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263311AbTEIQ5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 12:57:45 -0400
Date: Fri, 9 May 2003 13:07:12 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305091309_MC3-1-3826-6B64@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> >   What keeps users from opening files before the upper layer
> > filesystems get mounted?
>
> Nothing.  Why would we want to do such silly things?

  If I installed a virus scanner I would hope it could do that, otherwise
I might screw up and forget to set up all the layering just once and
get infected.  If I can tell it "protect all local filesystems" then
I can forget about it from then on.


