Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbTD0SKK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 14:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTD0SKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 14:10:09 -0400
Received: from holomorphy.com ([66.224.33.161]:25279 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261177AbTD0SKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 14:10:09 -0400
Date: Sun, 27 Apr 2003 11:22:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: rmoser <mlmoser@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Re:  Swap Compression
Message-ID: <20030427182211.GY8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	rmoser <mlmoser@comcast.net>, linux-kernel@vger.kernel.org
References: <200304251848410590.00DEC185@smtp.comcast.net> <20030426091747.GD23757@wohnheim.fh-wedel.de> <200304261148590300.00CE9372@smtp.comcast.net> <20030426160920.GC21015@wohnheim.fh-wedel.de> <200304262224040410.031419FD@smtp.comcast.net> <20030427090418.GB6961@wohnheim.fh-wedel.de> <200304271324370750.01655617@smtp.comcast.net> <20030427175147.GA5174@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030427175147.GA5174@wohnheim.fh-wedel.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 27, 2003 at 07:51:47PM +0200, J?rn Engel wrote:
> Segments are old, stupid and x86 only. What you want is a number of
> pages, maybe just one at a time. Always compress chunks of the same
> size and you don't have to guess the decompressed size.

Well, not really, but x86's notion of segments differs substantially
from that held by other cpus.


-- wli
