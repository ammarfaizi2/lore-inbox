Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268411AbUIWMTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268411AbUIWMTD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 08:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268420AbUIWMTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 08:19:03 -0400
Received: from holub.nextsoft.cz ([195.122.198.235]:4736 "EHLO
	holub.nextsoft.cz") by vger.kernel.org with ESMTP id S268411AbUIWMTB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 08:19:01 -0400
From: Michal Rokos <michal@rokos.info>
To: thockin@hockin.org
Subject: Re: [PATCH 2.6] Natsemi - remove compilation warnings
Date: Thu, 23 Sep 2004 16:18:56 +0200
User-Agent: KMail/1.7
References: <200409230958.31758.michal@rokos.info>
In-Reply-To: <200409230958.31758.michal@rokos.info>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409231618.56861.michal@rokos.info>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On Thursday 23 of September 2004 09:58, you wrote:
> natsemi driver emits a lot of warnings.
> This patch make compilation calm again.
> Code taken from drivers/net/pci-skeleton.c. Thanks Jeff.

This patch unfortunately makes natsemi stop working... :(

Sorry for sending bad patch - I've been testing it, but loaded the other 
module.

Sorry once again.

 Michal

