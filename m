Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264407AbTFIOqk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 10:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbTFIOqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 10:46:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44948 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264407AbTFIOqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 10:46:39 -0400
Date: Mon, 09 Jun 2003 07:57:09 -0700 (PDT)
Message-Id: <20030609.075709.82116509.davem@redhat.com>
To: chas@cmf.nrl.navy.mil
Cc: baldrick@wanadoo.fr, wa@almesberger.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2) 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200306091456.h59Eu5sG022768@ginger.cmf.nrl.navy.mil>
References: <20030609.070014.118613484.davem@redhat.com>
	<200306091456.h59Eu5sG022768@ginger.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@cmf.nrl.navy.mil>
   Date: Mon, 09 Jun 2003 10:54:13 -0400
   
   you could say open vcp.vci but i dont care which interface you use.

Ok, this reminds me that we need to figure out how MPLS
figures into all of this..  sorry I've fallen behind in my
studies in this area.
