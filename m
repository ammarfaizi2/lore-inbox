Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292904AbSCDUxj>; Mon, 4 Mar 2002 15:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292907AbSCDUx3>; Mon, 4 Mar 2002 15:53:29 -0500
Received: from hermes.toad.net ([162.33.130.251]:58091 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S292904AbSCDUxV>;
	Mon, 4 Mar 2002 15:53:21 -0500
Subject: Re: [PATCH] apm bootparam 2.4.18
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Mar 2002 15:54:15 -0500
Message-Id: <1015275257.4452.532.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Krennwallner wrote:
> Bootparam handling in apm.c is broken. apm=on and apm=off
> turns APM off, no bootparam turns apm on.

That's not true.  The existing code looks correct to me.

