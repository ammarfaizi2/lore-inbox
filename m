Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272054AbTGYNCx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 09:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272055AbTGYNCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 09:02:53 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27041 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272054AbTGYNCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 09:02:52 -0400
Date: Fri, 25 Jul 2003 06:15:16 -0700
From: "David S. Miller" <davem@redhat.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: guddadabhoota@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: IGMPv3 & kernel 2.6
Message-Id: <20030725061516.06d51be0.davem@redhat.com>
In-Reply-To: <20030725083559.GB6898@mea-ext.zmailer.org>
References: <20030724082659.26474.qmail@web41906.mail.yahoo.com>
	<20030725075503.37011.qmail@web41904.mail.yahoo.com>
	<20030725083559.GB6898@mea-ext.zmailer.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jul 2003 11:35:59 +0300
Matti Aarnio <matti.aarnio@zmailer.org> wrote:

> You are referring to RFC 2236/3376 ?
> 
> The 2.6 has it, while 2.4 does not.
> Back-portting is possible.

False, Marcelo's current 2.4.x sources has the
igmpv3 code in it.
