Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751831AbWCNFSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbWCNFSQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 00:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbWCNFSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 00:18:15 -0500
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:10101 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751831AbWCNFSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 00:18:14 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] drivers/input/gameport/gameport.c: fix a memory leak
Date: Tue, 14 Mar 2006 00:18:10 -0500
User-Agent: KMail/1.9.1
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <20060311151037.GN21864@stusta.de>
In-Reply-To: <20060311151037.GN21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603140018.10821.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 March 2006 10:10, Adrian Bunk wrote:
> This patch fixes a memory leak found by the Coverity checker.
>

Both patches applied, thank you Adrian.

Because the leak is very hard to trigger it will not be merged until
2.6.17 opens up.

-- 
Dmitry
