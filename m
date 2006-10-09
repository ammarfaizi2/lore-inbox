Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932940AbWJIPcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932940AbWJIPcl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 11:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932939AbWJIPcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 11:32:41 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:9088 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932940AbWJIPcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 11:32:39 -0400
Subject: Re: 2.6.19-rc1: known regressions (v2) - xfrm_register_mode
From: Steve Fox <drfickle@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, Mel Gorman <mel@skynet.ie>,
       Vivek Goyal <vgoyal@in.ibm.com>
In-Reply-To: <20061007214620.GB8810@stusta.de>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	 <20061007214620.GB8810@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 09 Oct 2006 10:32:34 -0500
Message-Id: <1160407954.1984.11.camel@flooterbu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-07 at 23:46 +0200, Adrian Bunk wrote:
> Subject    : oops in xfrm_register_mode
> References : http://lkml.org/lkml/2006/10/4/170
> Submitter  : Steve Fox <drfickle@us.ibm.com>
> Status     : unknown

Status: Vivek and Mel have both created patches which fix the boot
issue, but it is not clear to me if either of these are acceptable
fixes.

-- 

Steve Fox
IBM Linux Technology Center
