Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVACQ7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVACQ7R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 11:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVACQ7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 11:59:16 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:28336 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261911AbVACQ7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 11:59:01 -0500
Subject: Re: starting with 2.7
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Adrian Bunk <bunk@stusta.de>,
       William Lee Irwin III <wli@debian.org>,
       Andries Brouwer <aebr@win.tue.nl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050103003011.GP29332@holomorphy.com>
References: <20050102221534.GG4183@stusta.de> <41D87A64.1070207@tmr.com>
	 <20050103003011.GP29332@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104766594.12807.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 03 Jan 2005 15:52:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It isn't a good assumption that rate of change drives rate of errors and
need for testing. It is one factor but the amount of review, the
modularity of the code and the effectiveness of the management and
verification tools are all involved greatly.

