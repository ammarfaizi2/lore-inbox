Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVAaTXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVAaTXx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 14:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVAaTXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 14:23:53 -0500
Received: from peabody.ximian.com ([130.57.169.10]:48526 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261321AbVAaTXw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 14:23:52 -0500
Subject: Re: [-mm patch] inotify.c: make code static
From: Robert Love <rml@novell.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050131124223.GF18316@stusta.de>
References: <20050131124223.GF18316@stusta.de>
Content-Type: text/plain
Date: Mon, 31 Jan 2005 14:18:45 -0500
Message-Id: <1107199125.4019.4.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-31 at 13:42 +0100, Adrian Bunk wrote:

> This patch makes needlessly global code static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Thanks.  I applied this to my inotify tree.

	Robert Love


