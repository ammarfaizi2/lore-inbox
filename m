Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUE3Gx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUE3Gx6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 02:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUE3Gx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 02:53:58 -0400
Received: from hera.kernel.org ([63.209.29.2]:42643 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261857AbUE3Gx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 02:53:56 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: ftp.kernel.org
Date: Sun, 30 May 2004 06:52:47 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c9c0bv$g7b$1@terminus.zytor.com>
References: <jbglaw@lug-owl.de> <200405292105.i4TL5mdT004928@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1085899967 16620 127.0.0.1 (30 May 2004 06:52:47 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sun, 30 May 2004 06:52:47 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200405292105.i4TL5mdT004928@pincoya.inf.utfsm.cl>
By author:    Horst von Brand <vonbrand@inf.utfsm.cl>
In newsgroup: linux.dev.kernel
> 
> > If you see aborts [with rsync], properly set the timeout parameter...
> 
> With mirror you can use file patterns to include/exclude (e.g. get just the
> .bz2 versions (not redundant .gz)), only consider "new" files (i.e.,
> exclude anything more than a week old), etc.
> 

You can do that with rsync as well.  If there is something specific
you need that isn't there I'm sure if you report it it will be there
soon, too.

	-hpa
