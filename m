Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTKRDSk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 22:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbTKRDSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 22:18:39 -0500
Received: from rth.ninka.net ([216.101.162.244]:6016 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262324AbTKRDSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 22:18:39 -0500
Date: Mon, 17 Nov 2003 19:18:17 -0800
From: "David S. Miller" <davem@redhat.com>
To: Christopher Cyrus <dust_ml@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ipchains crashing in 2.6.0-test9
Message-Id: <20031117191817.60ebda93.davem@redhat.com>
In-Reply-To: <20031117220931.79fdd609.dust_ml@gmx.de>
References: <20031117220931.79fdd609.dust_ml@gmx.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003 22:09:31 +0100
Christopher Cyrus <dust_ml@gmx.de> wrote:

> My masqueradeing with ipchains causes a system freeze after the first
> transmittet packages with my 2.6.0-test9.
> perhaps anyone is using this "ancient technology", too. ;)

This is definitely fixed in the current 2.6.x sources, please
give it a try.

(And please in the future post this kind of report to the networking
 and netfilter mailing lists, thanks.)
