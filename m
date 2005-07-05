Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVGEPOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVGEPOL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 11:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVGEPOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 11:14:10 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:21771 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261862AbVGEPAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 11:00:02 -0400
Date: Tue, 5 Jul 2005 10:59:49 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: [PATCH] 8139cp - redetect link after suspend
Message-ID: <20050705145945.GA21933@tuxdriver.com>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
References: <42C8653D.9040103@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C8653D.9040103@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2005 at 12:22:53AM +0200, Pierre Ossman wrote:
> After suspend the driver needs to retest link status in case the cable
> has been inserted or removed during the suspend.
> 
> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

Please copy netdev@vger.kernel.org for network driver patches.

Other than that, the patch looks acceptable to me, fwiw...

John
-- 
John W. Linville
linville@tuxdriver.com
