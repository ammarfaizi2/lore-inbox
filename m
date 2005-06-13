Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVFMDbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVFMDbc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 23:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVFMDbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 23:31:31 -0400
Received: from mail.dvmed.net ([216.237.124.58]:56289 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261336AbVFMDba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 23:31:30 -0400
Message-ID: <42ACFE0C.1080604@pobox.com>
Date: Sun, 12 Jun 2005 23:31:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 2.6.12-rc6] 3c59x: remove superfluous vortex_debug test
 from boomerang_start_xmit
References: <20050610142702.GC10449@tuxdriver.com>
In-Reply-To: <20050610142702.GC10449@tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> Remove the superfluous test of "if (vortex_debug > 3)" inside the
> "if (vortex_debug > 6)" clause early in boomerang_start_xmit.
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>

ACK (I presume akpm will send this one upstream)


