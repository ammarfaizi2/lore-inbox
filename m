Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWAVTRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWAVTRX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 14:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWAVTRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 14:17:23 -0500
Received: from relay01.pair.com ([209.68.5.15]:50185 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S1750741AbWAVTRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 14:17:22 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
Date: Sun, 22 Jan 2006 13:16:54 -0600
User-Agent: KMail/1.9
Cc: Ariel <askernel2615@dsgml.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz> <Pine.LNX.4.62.0601221251340.30208@pureeloreel.qftzy.pbz> <1137956841.3328.36.camel@laptopd505.fenrus.org>
In-Reply-To: <1137956841.3328.36.camel@laptopd505.fenrus.org>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601221317.17124.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 January 2006 13:06, Arjan van de Ven wrote:
> I see you also use vmware. The other person who reported this also uses
> vmware. Could you please repeat the test without BOTH the nvidia and
> vmware modules?

Arjan,
	FYI - I reported this as well and I do not use VMWare.

Cheers,
Chase
