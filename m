Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbTFJWGh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 18:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbTFJWGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 18:06:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49056 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262257AbTFJWGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 18:06:37 -0400
Date: Tue, 10 Jun 2003 15:16:58 -0700 (PDT)
Message-Id: <20030610.151658.39176866.davem@redhat.com>
To: wa@almesberger.net
Cc: chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030610183409.R3232@almesberger.net>
References: <20030608004540.P3232@almesberger.net>
	<1055054601.30054.4.camel@rth.ninka.net>
	<20030610183409.R3232@almesberger.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Werner Almesberger <wa@almesberger.net>
   Date: Tue, 10 Jun 2003 18:34:09 -0300

   Is this mature enough in 2.5.70 to make it worth looking for holes,
   or should I rather wait a bit ?

Wait about a month or two :)
