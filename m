Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269227AbUISMwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269227AbUISMwz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 08:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269240AbUISMwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 08:52:54 -0400
Received: from mail48-s.fg.online.no ([148.122.161.48]:29830 "EHLO
	mail48-s.fg.online.no") by vger.kernel.org with ESMTP
	id S269227AbUISMwx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 08:52:53 -0400
From: Kenneth =?iso-8859-1?q?Aafl=F8y?= <lists@kenneth.aafloy.net>
To: Roger Luethi <rl@hellgate.ch>
Subject: Re: [BUG] Via-Rhine WOL vs PXE Boot
Date: Sun, 19 Sep 2004 14:52:51 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200409172154.36550.lists@kenneth.aafloy.net> <200409180001.42332.lists@kenneth.aafloy.net> <20040918061331.GA12757@k3.hellgate.ch>
In-Reply-To: <20040918061331.GA12757@k3.hellgate.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200409191452.51507.lists@kenneth.aafloy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 September 2004 08:13, Roger Luethi wrote:
> On Sat, 18 Sep 2004 00:01:42 +0200, Kenneth Aafløy wrote:
> > I've attached what I belive to be a bk patch (kinda new to that) which 
> > comments out this power-state change, untill something better is found. I 
> > have not tested WOL with this, but I can't think of any reason why it should 
> > not work.
> 
> I'm afraid you will convince neither me nor the hardware with assumptions.

WOL still works fine, at least with my hardware, without that statement.

Kenneth
