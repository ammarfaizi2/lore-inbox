Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUGPPLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUGPPLJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 11:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266549AbUGPPLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 11:11:09 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:49302 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266519AbUGPPLH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 11:11:07 -0400
Subject: Re: [LTP] LTP Results - July 15, 2004
From: Paul Larson <plars@linuxtestproject.org>
To: Bryce Harrington <bryce@osdl.org>
Cc: ltp-list@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0407152041550.5901-100000@osdlab.pdx.osdl.net>
References: <Pine.LNX.4.33.0407152041550.5901-100000@osdlab.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1089990640.3151.108.camel@plars.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 16 Jul 2004 10:10:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-15 at 22:42, Bryce Harrington wrote:
> (Sorry, this time _with_ a subject line)
> 
> LTP version LTP-20040506:
> 
> Patch Name           TestReq#     CPU  PASS  FAIL  WARN  BROK  RunTime
> ----------------------------------------------------------------------
> 2.6.7-mm7              294831  2-way  7184    45     3     6    44.0
These are clearly not valid failures.  How are you running ltp?  Any
chance you are running out of disk space in /tmp?

-Paul Larson

