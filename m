Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVBTCNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVBTCNU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 21:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVBTCNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 21:13:19 -0500
Received: from smtp.knology.net ([24.214.63.101]:39810 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261346AbVBTCNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 21:13:09 -0500
Subject: Re: [2.6 patch] drivers/net/typhoon: make a firmware image static
From: David Dillow <dave@thedillows.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050219084325.GT4337@stusta.de>
References: <20050219084325.GT4337@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Feb 2005 21:13:18 -0500
Message-Id: <1108865598.6051.4.camel@ori.thedillows.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-19 at 09:43 +0100, Adrian Bunk wrote:
> This patch makes a nedlessly global firmware image static.

Doh! ACK.
-- 
David Dillow <dave@thedillows.org>
