Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263790AbTEWGr5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 02:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbTEWGr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 02:47:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11491 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263790AbTEWGry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 02:47:54 -0400
Date: Thu, 22 May 2003 23:59:05 -0700 (PDT)
Message-Id: <20030522.235905.42785280.davem@redhat.com>
To: lists@mdiehl.de
Cc: akpm@digeo.com, greg@kroah.com, linux-kernel@vger.kernel.org,
       jt@hpl.hp.com
Subject: Re: [2.5.69] rtnl-deadlock with usermodehelper and keventd
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0305230840140.14825-100000@notebook.home.mdiehl.de>
References: <20030515181211.5853fd18.akpm@digeo.com>
	<Pine.LNX.4.44.0305230840140.14825-100000@notebook.home.mdiehl.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Martin Diehl <lists@mdiehl.de>
   Date: Fri, 23 May 2003 09:06:10 +0200 (CEST)
   
   Asking just because there was another user hitting this deadlock:

It's fixed in current 2.5.x sources, wake up :-)
