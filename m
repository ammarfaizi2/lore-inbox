Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263236AbTJURrv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 13:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263238AbTJURru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 13:47:50 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:33810 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263236AbTJURrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 13:47:49 -0400
Date: Tue, 21 Oct 2003 18:47:41 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Andrew Morton <akpm@osdl.org>
cc: Valdis.Kletnieks@vt.edu, <schlicht@uni-mannheim.de>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: 2.6.0-test8-mm1
In-Reply-To: <20031020185613.7d670975.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0310211846210.32738-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay I see people are having alot of problems in the -mm tree. I don't 
have any problems but I'm working against Linus tree. Could people try the 
patch against 2.6.0-test8 and tell me if they still have the same results. 
I have a new patch here:

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz


