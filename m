Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbVIFKcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbVIFKcH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 06:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbVIFKcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 06:32:07 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:31981 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964791AbVIFKcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 06:32:06 -0400
Date: Tue, 6 Sep 2005 06:29:16 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: kernel status (clock running at double speed)
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200509060631_MC3-1-A94D-917A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20050905135546.7732ec27.akpm@osdl.org>

On Mon, 5 Sep 2005 at 13:55:46 -0700, Andrew Morton wrote:


> [2.6.13 bug] i386: Wall clock running at double speed


  Please track bug #3927 for this one.  I updated it with my information.
Both i386 and x86_64 will need a fix.


__
Chuck
