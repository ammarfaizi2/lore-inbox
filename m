Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265305AbSLFSdi>; Fri, 6 Dec 2002 13:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265369AbSLFSdi>; Fri, 6 Dec 2002 13:33:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:58854 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265305AbSLFSdg>;
	Fri, 6 Dec 2002 13:33:36 -0500
Date: Fri, 06 Dec 2002 10:38:08 -0800 (PST)
Message-Id: <20021206.103808.60419462.davem@redhat.com>
To: willy@debian.org
Cc: adam@yggdrasil.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021206183609.D16341@parcelfarce.linux.theplanet.co.uk>
References: <200212061619.IAA22144@baldur.yggdrasil.com>
	<20021206.101715.113691767.davem@redhat.com>
	<20021206183609.D16341@parcelfarce.linux.theplanet.co.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matthew Wilcox <willy@debian.org>
   Date: Fri, 6 Dec 2002 18:36:09 +0000
   
   As I indicated to Adam, there's a fairly limited range of devices
   available for these systems and there shouldn't be a huge problem
   converting the few drivers we need to these interfaces.

Ok, so to reiterate my other email, I'm fine with this as long as
suitable names are used to describe what is happening in the API
and to avoid confusion with existing practice.

   
