Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTLIKjC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 05:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbTLIKjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 05:39:02 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:58820 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S262126AbTLIKi7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 05:38:59 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: State of devfs in 2.6?
Date: Tue, 9 Dec 2003 10:37:20 +0000
User-Agent: KMail/1.5.4
References: <200312081536.26022.andrew@walrond.org> <200312081559.04771.andrew@walrond.org> <20031208233840.GD31370@kroah.com>
In-Reply-To: <20031208233840.GD31370@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312091037.20770.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My initial query has thrown up lots of interesting debate :)

I, like most people I suspect, love the concept of a complete auto-populated 
dev directory, and not having to MAKEDEV.

devfs provided this, but like most people who read LKML, I stopped using it 
when it's problems were discussed.

I really hope udev lives up to its promise, unlike devfs. Manually creating /
dev just annoys me for no apparent reason other than it's plain inelegance I 
suppose.

Andrew Walrond

