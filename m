Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbTJMQJJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 12:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbTJMQJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 12:09:09 -0400
Received: from [217.157.19.70] ([217.157.19.70]:12562 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S261881AbTJMQJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 12:09:07 -0400
Date: Mon, 13 Oct 2003 17:09:05 +0100 (BST)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: Rik van Riel <riel@surriel.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][TRIVIAL] question marks again
In-Reply-To: <Pine.LNX.4.55L.0310131154110.27244@imladris.surriel.com>
Message-ID: <Pine.LNX.4.40.0310131708290.25290-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Oct 2003, Rik van Riel wrote:

> No question about it.
>
> diff -urNp linux-5110/drivers/scsi/imm.c linux-10010/drivers/scsi/imm.c
> --- linux-5110/drivers/scsi/imm.c
> +++ linux-10010/drivers/scsi/imm.c
> @@ -322,10 +322,10 @@ static unsigned char imm_wait(int host_n
>       * STR      imm     imm
>       * ===================================
>       * 0x80     S_REQ   S_REQ
> -     * 0x40     !S_BSY  (????)
> +     * 0x40     !S_BSY  (?)
>       * 0x20     !S_CD   !S_CD
>       * 0x10     !S_IO   !S_IO
> -     * 0x08     (????)  !S_BSY
> +     * 0x08     (?)  !S_BSY

At least keep it lined up..

// Thomas

