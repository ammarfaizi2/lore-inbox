Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbUISWAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbUISWAP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 18:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUISWAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 18:00:15 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:38058 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S264531AbUISWAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 18:00:03 -0400
Message-ID: <35fb2e5904091915007c02c4b8@mail.gmail.com>
Date: Sun, 19 Sep 2004 23:00:00 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Sergei Haller <sergei.haller@math.uni-giessen.de>
Subject: Re: lost memory on a 4GB amd64
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409200737010.3644@fb07-calculator.math.uni-giessen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
	 <200409161528.19409.andrew@walrond.org>
	 <Pine.LNX.4.58.0409170051200.26494@fb07-calculator.math.uni-giessen.de>
	 <200409161619.28742.andrew@walrond.org>
	 <Pine.LNX.4.58.0409170147320.26494@fb07-calculator.math.uni-giessen.de>
	 <Pine.LNX.4.58.0409190007530.31971@fb07-calculator.math.uni-giessen.de>
	 <35fb2e59040919130154966337@mail.gmail.com>
	 <Pine.LNX.4.58.0409200737010.3644@fb07-calculator.math.uni-giessen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2004 07:47:20 +1000 (EST), Sergei Haller 

> I guess I should write a simple C-program using malloc or something to
> reproduce the crash in the simplest possible way, shouldn't I?

You've answered your own question Sergei. Thing is - you mentioned the
AGP aperature settings in your original post and then got tied up
thinking there's a bug in the kernel but we have to rule out stuff
like X getting very unhappy trying to play in the wrong place or
something. Try a simple test case and then see if you can give any
other handy details on your situation.

Jon.
