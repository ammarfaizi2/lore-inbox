Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbTIDD3F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264553AbTIDD3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:29:05 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15274 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264601AbTIDD3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:29:03 -0400
Date: Wed, 3 Sep 2003 20:19:20 -0700
From: "David S. Miller" <davem@redhat.com>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: pekkas@netcore.fi, yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH] Kill unneeded linux/version.h include in net/ipv6
Message-Id: <20030903201920.15625d8e.davem@redhat.com>
In-Reply-To: <3F55F4DD.9070301@terra.com.br>
References: <3F55F4DD.9070301@terra.com.br>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Sep 2003 11:04:13 -0300
Felipe W Damasio <felipewd@terra.com.br> wrote:

> 	Removes an unneeded linux/version.h include from af_inet6..

Applied, thanks.
