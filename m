Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266339AbUGJSny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266339AbUGJSny (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 14:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUGJSny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 14:43:54 -0400
Received: from fep16.inet.fi ([194.251.242.241]:26523 "EHLO fep16.inet.fi")
	by vger.kernel.org with ESMTP id S266339AbUGJSnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 14:43:53 -0400
From: Jan Knutar <jk-lkml@sci.fi>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: XFS: how to NOT null files on fsck?
Date: Sat, 10 Jul 2004 21:43:49 +0300
User-Agent: KMail/1.6.2
Cc: L A Walsh <lkml@tlinx.org>,
       Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       linux-kernel@vger.kernel.org
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx> <40EEC9DC.8080501@tlinx.org> <20040709215955.GA24857@taniwha.stupidest.org>
In-Reply-To: <20040709215955.GA24857@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407102143.49838.jk-lkml@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 July 2004 00:59, Chris Wedgwood wrote:

> I *never* see this even when beating the hell out of machines and
> trying to break things.

I've seen this on a partition with NO other activity, than me editing a .c
file with emacs in a project consisting of about 4 files in total, compiling
and testingocasionally, editing again, etc... Then one day, powerloss, 
when power came back, the file was nothing but null. Atleast it had 
correct size and timestamp though, great comfort, that. :)

