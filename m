Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268347AbUHQRR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268347AbUHQRR1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 13:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268349AbUHQRR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 13:17:26 -0400
Received: from [12.177.129.25] ([12.177.129.25]:29635 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268347AbUHQRQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 13:16:51 -0400
Message-Id: <200408171817.i7HIHrKF003284@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Andreas Schwab <schwab@suse.de>
cc: Andrew Morton <akpm@osdl.org>, kai@germaschewski.name, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] 2.6.8-rc4-mm1 - Fix UML build 
In-Reply-To: Your message of "Tue, 17 Aug 2004 10:55:51 +0200."
             <jellge9m94.fsf@sykes.suse.de> 
References: <200408120414.i7C4EtJd010481@ccure.user-mode-linux.org> <20040815150635.5ac4f5df.akpm@osdl.org> <200408170602.i7H62LNj019126@ccure.user-mode-linux.org>  <jellge9m94.fsf@sykes.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Aug 2004 14:17:53 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

schwab@suse.de said:
> Try gcc -print-search-dirs. 

Ah, excellent, thanks very much.  I had looked around gcc's info, but I missed
that.

				Jeff

