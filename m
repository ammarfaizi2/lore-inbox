Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263256AbTJBGHK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 02:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTJBGHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 02:07:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:65167 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263256AbTJBGHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 02:07:08 -0400
Date: Wed, 1 Oct 2003 23:07:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH on sparse] - was Re: [PATCH] fat sparse fixes
In-Reply-To: <UTC200310020146.h921kqg15004.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0310012306160.3199-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2 Oct 2003 Andries.Brouwer@cwi.nl wrote:
> 
> Please examine the below diff.

Yes, this is the right thing to do. I fixed the bug slightly differently, 
but with the same effect. Thanks,

		Linus

