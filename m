Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423221AbWF1JYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423221AbWF1JYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 05:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030487AbWF1JYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 05:24:36 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:33692
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030360AbWF1JYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 05:24:35 -0400
Date: Wed, 28 Jun 2006 02:24:33 -0700 (PDT)
Message-Id: <20060628.022433.71087107.davem@davemloft.net>
To: akpm@osdl.org
Cc: mingo@elte.hu, tglx@linutronix.de, bunk@stusta.de,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: [patch] genirq: rename desc->handler to desc->chip, sparc64 fix
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060628014807.0694436f.akpm@osdl.org>
References: <20060628083008.GA14056@elte.hu>
	<20060628.013940.41192890.davem@davemloft.net>
	<20060628014807.0694436f.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Wed, 28 Jun 2006 01:48:07 -0700

> I'm thinking Thursday/Fridayish.  Is that OK?

Sure :)
