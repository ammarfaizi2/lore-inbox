Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262819AbVDAR1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbVDAR1j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 12:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbVDAR1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 12:27:39 -0500
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:18621 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S262819AbVDAR1f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 12:27:35 -0500
Subject: Re: AMD64 Machine hardlocks when using memset
From: Ray Lee <ray-lk@madrabbit.org>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <424CD018.5000005@shaw.ca>
References: <3NTHD-8ih-1@gated-at.bofh.it> <3O99L-40N-9@gated-at.bofh.it>
	 <424CD018.5000005@shaw.ca>
Content-Type: text/plain
Organization: http://madrabbit.org/
Date: Fri, 01 Apr 2005 09:27:33 -0800
Message-Id: <1112376453.16982.14.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-31 at 22:37 -0600, Robert Hancock wrote:
> This is getting pretty ridiculous.. I've tried memory timings down to 
> the slowest possible, ran Memtest86 for 4 passes with no errors, and 
> it's been stable in Windows for a few months now. Still something is 
> blowing up in Linux with this test though..

Have you run the same memset test under windows?

I've traced a lot of oddball problems down to bad or marginal power
supplies.

Ray

