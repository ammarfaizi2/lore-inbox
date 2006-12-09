Return-Path: <linux-kernel-owner+w=401wt.eu-S1758303AbWLIV7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758303AbWLIV7h (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 16:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758738AbWLIV7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 16:59:36 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:33714
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1758682AbWLIV7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 16:59:35 -0500
Date: Sat, 09 Dec 2006 13:59:36 -0800 (PST)
Message-Id: <20061209.135936.106278973.davem@davemloft.net>
To: ralf@linux-mips.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [ATM] Ignore generated file pca200e_ecd.bin2
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061209162626.GA13788@linux-mips.org>
References: <20061209162626.GA13788@linux-mips.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralf Baechle <ralf@linux-mips.org>
Date: Sat, 9 Dec 2006 16:26:26 +0000

> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> diff --git a/drivers/atm/.gitignore b/drivers/atm/.gitignore
> index a165b71..fc0ae5e 100644
> --- a/drivers/atm/.gitignore
> +++ b/drivers/atm/.gitignore
> @@ -2,4 +2,4 @@ # Ignore generated files
>  fore200e_mkfirm
>  fore200e_pca_fw.c
>  pca200e.bin
> -
> +pca200e_ecd.bin2

Applied, thanks Ralf.
