Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbUBWCRs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 21:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbUBWCRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 21:17:48 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:6300 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261370AbUBWCRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 21:17:47 -0500
Date: Sun, 22 Feb 2004 21:17:41 -0500
From: Tom Vier <tmv@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Intel vs AMD x86-64
Message-ID: <20040223021741.GC29720@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <Pine.LNX.4.58.0402171739020.2686@home.osdl.org> <16435.14044.182718.134404@alkaid.it.uu.se> <Pine.LNX.4.58.0402180744440.2686@home.osdl.org> <20040222025957.GA31813@MAIL.13thfloor.at> <Pine.LNX.4.58.0402211907100.3301@ppc970.osdl.org> <40382C47.70603@coyotegulch.com> <40394BA3.4070307@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40394BA3.4070307@techsource.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 07:38:59PM -0500, Timothy Miller wrote:
> In theory, IEEE FP is IEEE FP, but it seems that Intel may have cheated 
> in their design, silently reducing precision for the sake of some other 
> aspect of their design, making their processors less useful (or 
> useless?) for scientific applications.  Another example of Intel 
> arrogance?  Or perhaps a reasonable design compromise?  You decide.

did they use -miiie? was the same compiler (exact same version) used? if the
answer to either is no, that would account for the difference.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0xE6CB97DA
