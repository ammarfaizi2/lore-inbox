Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268559AbTGUPVZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 11:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269334AbTGUPVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 11:21:25 -0400
Received: from svr7.m-online.net ([62.245.150.229]:10116 "EHLO
	svr7.m-online.net") by vger.kernel.org with ESMTP id S268559AbTGUPVX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 11:21:23 -0400
Date: Mon, 21 Jul 2003 17:38:26 +0200
From: Florian Huber <florian.huber@mnet-online.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test1-mm2] unable to mount root fs on unknown-block(0,0)
Message-Id: <20030721173826.333bfa01.florian.huber@mnet-online.de>
In-Reply-To: <1058738091.5980.63.camel@localhost.localdomain>
References: <20030720125547.11466aa4.florian.huber@mnet-online.de>
	<1058738091.5980.63.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jul 2003 14:54:52 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Setting root=0303 (in your case) might helps things along.

Thanks Jeremy, it's working :)

