Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVACTp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVACTp7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 14:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVACTp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 14:45:59 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:22446 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261480AbVACTp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 14:45:56 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: mshefty@ichips.intel.com, halr@voltaire.com, openib-general@openib.org,
       linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <20050103171937.GG2980@stusta.de>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 03 Jan 2005 11:45:53 -0800
In-Reply-To: <20050103171937.GG2980@stusta.de> (Adrian Bunk's message of
 "Mon, 3 Jan 2005 18:19:37 +0100")
Message-ID: <52sm5i70um.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [2.6 patch] infiniband: possible cleanups
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 03 Jan 2005 19:45:54.0365 (UTC) FILETIME=[D64476D0:01C4F1CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I've applied the changes adding "static" to our tree.  I'm
holding off on the "#if 0" changes since some is code useful for
debugging modules and other code is used by modules in development.

Thanks,
  Roland

