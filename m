Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTFOQGF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 12:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTFOQGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 12:06:05 -0400
Received: from rth.ninka.net ([216.101.162.244]:51328 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262324AbTFOQGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 12:06:03 -0400
Subject: Re: 2.5.71 -- Lost second 3c509 card
From: "David S. Miller" <davem@redhat.com>
To: Pete Clements <clem@clem.clem-digital.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200306151319.JAA04754@clem.clem-digital.net>
References: <200306151319.JAA04754@clem.clem-digital.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055693991.7678.0.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jun 2003 09:19:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-15 at 06:19, Pete Clements wrote:
> As a followup, reverted the 3c509 bk10 changes. Back in business
> with 2.5.71.

Are you using command line port number specifications?
If so, what do they look like?

-- 
David S. Miller <davem@redhat.com>
