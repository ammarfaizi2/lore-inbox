Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbVHQTFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVHQTFx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 15:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVHQTFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 15:05:53 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:28093
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751208AbVHQTFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 15:05:52 -0400
Date: Wed, 17 Aug 2005 12:05:45 -0700 (PDT)
Message-Id: <20050817.120545.13032587.davem@davemloft.net>
To: paulmck@us.ibm.com
Cc: steve@chygwyn.com, suzannew@cs.pdx.edu, linux-kernel@vger.kernel.org,
       walpole@cs.pdx.edu, patrick@tykepenguin.com
Subject: Re: rcu read-side protection
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050817141438.GD1300@us.ibm.com>
References: <20050817020156.GF1319@us.ibm.com>
	<20050817082552.GA25537@souterrain.chygwyn.com>
	<20050817141438.GD1300@us.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@us.ibm.com>
Date: Wed, 17 Aug 2005 07:14:38 -0700

> Fix RCU race condition in dn_neigh_construct().

Applied, thanks Paul.
