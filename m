Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030914AbWKOTQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030914AbWKOTQy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030916AbWKOTQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:16:54 -0500
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:56451
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1030914AbWKOTQw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:16:52 -0500
From: Michael Buesch <mb@bu3sch.de>
To: Ray Lee <ray-lk@madrabbit.org>
Subject: Re: bcm43xx regression 2.6.19rc3 -> rc5, rtnl_lock trouble?
Date: Wed, 15 Nov 2006 20:15:07 +0100
User-Agent: KMail/1.9.5
References: <455B63EC.8070704@madrabbit.org>
In-Reply-To: <455B63EC.8070704@madrabbit.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, Bcm43xx-dev@lists.berlios.de,
       LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       John Linville <linville@tuxdriver.com>, Michael Buesch <mb@bu3sch.de>,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611152015.07844.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 20:01, Ray Lee wrote:
> Suggestions? Requests for <shudder> even more info?

Yeah, enable bcm43xx debugging.

-- 
Greetings Michael.
