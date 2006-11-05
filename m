Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422773AbWKEWvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422773AbWKEWvm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 17:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422774AbWKEWvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 17:51:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:34722 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1422773AbWKEWvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 17:51:41 -0500
Subject: Re: [PATCH 2.6.19 4/4] ehca: ehca_av.c use constant for max mtu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
Cc: rolandd@cisco.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <200611052142.56722.hnguyen@de.ibm.com>
References: <200611052142.56722.hnguyen@de.ibm.com>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 09:48:40 +1100
Message-Id: <1162766921.28571.251.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you fix your patch sending technique ? A mangled patch inline with a
non-mangled one in attachment... that's a bit gross. Just get a proper
one inline and be done with it. If your mailer can't be coerced into not
damaging patches, then use another one for sending them.

Cheers,
Ben


