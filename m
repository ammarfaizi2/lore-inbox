Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWGRVas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWGRVas (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 17:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWGRVas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 17:30:48 -0400
Received: from mail.suse.de ([195.135.220.2]:12245 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932103AbWGRVar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 17:30:47 -0400
From: Andreas Schwab <schwab@suse.de>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Thomas Dillig <tdillig@stanford.edu>, linux-kernel@vger.kernel.org
Subject: Re: Null dereference errors in the kernel
References: <44BC5A3F.2080005@stanford.edu>
	<20060718181631.13f6f052@doriath.conectiva>
X-Yow: I wonder if I could ever get started in the credit world?
Date: Tue, 18 Jul 2006 23:30:43 +0200
In-Reply-To: <20060718181631.13f6f052@doriath.conectiva> (Luiz Fernando
	N. Capitulino's message of "Tue, 18 Jul 2006 18:16:31 -0300")
Message-ID: <jeu05e4n3w.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> writes:

> On Mon, 17 Jul 2006 20:49:19 -0700
> Thomas Dillig <tdillig@stanford.edu> wrote:
>
> | [4]
> | 239 drivers/usb/misc/usblcd.c
> | NULL dereference of variable "urb".
>
>  This is a false positive.

It is not, for 2.6.17. But the bug has already been fixed some time ago.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
