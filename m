Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264812AbTF0Vgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 17:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264830AbTF0Vgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 17:36:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60344 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264812AbTF0Vg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 17:36:29 -0400
Date: Fri, 27 Jun 2003 14:44:26 -0700 (PDT)
Message-Id: <20030627.144426.71096593.davem@redhat.com>
To: greearb@candelatech.com
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3EFC9203.3090508@candelatech.com>
References: <18330000.1056692768@[10.10.2.4]>
	<20030626.224739.88478624.davem@redhat.com>
	<3EFC9203.3090508@candelatech.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Fri, 27 Jun 2003 11:50:43 -0700

   It would also keep bugs from falling through the cracks:

People DON'T understand.  I _WANT_ them to be able to
fall through the cracks.

If it's important, people will retransmit.

This work for kernel patches, and has so for over 5 years.
So what makes anyone thing it doesn't work for bug reporting?
