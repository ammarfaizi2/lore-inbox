Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264524AbUD1A3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbUD1A3b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 20:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbUD1A3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 20:29:31 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:38345 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264545AbUD1A32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 20:29:28 -0400
Date: Tue, 27 Apr 2004 20:29:25 -0400
From: Tom Vier <tmv@comcast.net>
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
Message-ID: <20040428002925.GA9425@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <Pine.LNX.4.44.0404231300470.27087-100000@twin.uoregon.edu> <Pine.LNX.4.53.0404231624010.1352@chaos> <yw1xoepio24x.fsf@kth.se> <Pine.LNX.4.53.0404231651120.1643@chaos> <40898834.7040803@techsource.com> <20040424022458.GA16166@zero> <408E7FBE.7010700@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408E7FBE.7010700@techsource.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 11:43:58AM -0400, Timothy Miller wrote:
> The problem is track alignment.  Don't drives dedicate one track on one 
> platter as an alignment track?

it used to be one whole plater was for servo alignment, i think. embedded
servo signals have been around for at least 7 years.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
