Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWIUGhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWIUGhX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 02:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWIUGhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 02:37:22 -0400
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:19485 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1750719AbWIUGhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 02:37:21 -0400
Date: Thu, 21 Sep 2006 08:37:18 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ams: check return values from device_create_file()
Message-ID: <20060921063718.GA4079@hansmi.ch>
References: <20060921005647.GC16002@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921005647.GC16002@cathedrallabs.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 09:56:47PM -0300, Aristeu Sergio Rozanski Filho wrote:
> This patch changes ams driver in order to check device_create_file()
> return values and simplifies ams_sensor_attach().

> Signed-off-by: Aristeu S. Rozanski F. <aris@cathedrallabs.org>
Acked-By: Michael Hanselmann <linux-kernel@hansmi.ch>
