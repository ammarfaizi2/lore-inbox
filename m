Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVJTOHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVJTOHX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 10:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbVJTOHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 10:07:22 -0400
Received: from mail.dvmed.net ([216.237.124.58]:26028 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932066AbVJTOHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 10:07:16 -0400
Message-ID: <4357A491.8070901@pobox.com>
Date: Thu, 20 Oct 2005 10:07:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [patch 2.6.14-rc3] sundance: include MII address 0 in PHY probe
References: <10192005080734.15936@bilbo.tuxdriver.com>
In-Reply-To: <10192005080734.15936@bilbo.tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> Include MII address 0 at the end of the PHY scan.  This covers the
> entire range of possible MII addresses.
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>

applied


