Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264747AbTFLGio (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 02:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264754AbTFLGio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 02:38:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28332 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264747AbTFLGin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 02:38:43 -0400
Date: Wed, 11 Jun 2003 23:47:58 -0700 (PDT)
Message-Id: <20030611.234758.13746130.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <16102.14617.25302.441894@napali.hpl.hp.com>
References: <16097.36514.763047.738847@napali.hpl.hp.com>
	<20030607.001140.08328499.davem@redhat.com>
	<16102.14617.25302.441894@napali.hpl.hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Tue, 10 Jun 2003 13:01:29 -0700

   How about the attached patch?
   
Looks "Obviously correct" ;-)  I'll apply this, thanks.
