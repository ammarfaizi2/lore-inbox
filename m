Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVCaNDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVCaNDC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 08:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVCaNDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 08:03:01 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:39350 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261424AbVCaNCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 08:02:19 -0500
Date: Thu, 31 Mar 2005 15:01:55 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Yum Rayan <yum.rayan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Reduce stack usage in sys.c
Message-ID: <20050331130155.GB19294@wohnheim.fh-wedel.de>
References: <df35dfeb05033023445c386d2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df35dfeb05033023445c386d2d@mail.gmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 March 2005 23:44:38 -0800, Yum Rayan wrote:
> ------------
> sys_reboot - 256

Also not part of any deep stack trace I found.

Jörn

-- 
There is no worse hell than that provided by the regrets
for wasted opportunities.
-- Andre-Louis Moreau in Scarabouche
