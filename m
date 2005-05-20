Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVETQ4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVETQ4q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 12:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVETQ4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 12:56:46 -0400
Received: from adsl-66-218-37-216.dslextreme.com ([66.218.37.216]:60895 "EHLO
	tyanhuey") by vger.kernel.org with ESMTP id S261501AbVETQ4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 12:56:44 -0400
From: Russell Miller <rmiller@duskglow.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4 panic-on-oops
Date: Fri, 20 May 2005 09:53:46 -0700
User-Agent: KMail/1.8
Organization: Duskglow Consulting
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505200953.47159.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I sent this once before but it seems to have gotten lost in the ether.

Any chance of applying the panic-on-oops patch to the mainline 2.4 tree?  It 
should be a simple patch apply, there are only a couple of extraneous lines 
that don't seem to be necessary (the "tainted" stuff, which seems to belong 
in another patch).

Thanks.

--Russell
