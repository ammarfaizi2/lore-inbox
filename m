Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUCFPAs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 10:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbUCFPAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 10:00:48 -0500
Received: from ambr.mtholyoke.edu ([138.110.1.10]:26126 "EHLO
	ambr.mtholyoke.edu") by vger.kernel.org with ESMTP id S261682AbUCFPAl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 10:00:41 -0500
Date: Sat, 6 Mar 2004 10:00:40 -0500 (EST)
From: Ron Peterson <rpeterso@MtHolyoke.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: network / performance problems
In-Reply-To: <Pine.OSF.4.21.0403060952000.393748-100000@mhc.mtholyoke.edu>
Message-ID: <Pine.OSF.4.21.0403060958530.393748-100000@mhc.mtholyoke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 6 Mar 2004, Ron Peterson wrote:

> My understanding is that the kernel profile information will become
> interesting when the machine starts thrashing.  If it would be useful for
> me to dump anything before then, let me know.

On a related note...

What kind of performance hit do you take for booting with kernel profiling
turned on?  If not much, I would consider always booting this way, so that
if a machine starts sinking, I could maybe capture some useful
information.  Is that wise?

_________________________
Ron Peterson
Network & Systems Manager
Mount Holyoke College

