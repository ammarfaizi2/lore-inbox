Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbTEFODo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263729AbTEFOCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:02:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27368 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263730AbTEFOBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:01:41 -0400
Date: Tue, 06 May 2003 06:06:42 -0700 (PDT)
Message-Id: <20030506.060642.84373569.davem@redhat.com>
To: thomas@horsten.com
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
 defined (trivial)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305061510.04619.thomas@horsten.com>
References: <20030506104956.A29357@infradead.org>
	<1052215397.983.25.camel@rth.ninka.net>
	<200305061510.04619.thomas@horsten.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Horsten <thomas@horsten.com>
   Date: Tue, 6 May 2003 15:10:04 +0100
   
   So, would you prefer this:

Yes, this looks better.
