Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265372AbSJXJyg>; Thu, 24 Oct 2002 05:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbSJXJyg>; Thu, 24 Oct 2002 05:54:36 -0400
Received: from rth.ninka.net ([216.101.162.244]:50075 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S265372AbSJXJyg>;
	Thu, 24 Oct 2002 05:54:36 -0400
Subject: Re: bcm5700
From: "David S. Miller" <davem@rth.ninka.net>
To: Doruk Fisek <dfisek@fisek.com.tr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021024120604.1220fd46.dfisek@fisek.com.tr>
References: <20021024120604.1220fd46.dfisek@fisek.com.tr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Oct 2002 03:12:50 -0700
Message-Id: <1035454370.10555.0.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 02:06, Doruk Fisek wrote:
> What is the migration status of the driver to the standart kernel
> tree?

We already have a driver for the broadcom bcm570X chips, it's
called tg3.  Enable CONFIG_TIGON3 in your config and you'll
be ready to go.

