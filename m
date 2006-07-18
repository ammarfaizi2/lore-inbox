Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWGRWmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWGRWmR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 18:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWGRWmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 18:42:17 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:11932 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932304AbWGRWmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 18:42:17 -0400
Date: Tue, 18 Jul 2006 19:46:21 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Andreas Schwab <schwab@suse.de>
Cc: Thomas Dillig <tdillig@stanford.edu>, linux-kernel@vger.kernel.org
Subject: Re: Null dereference errors in the kernel
Message-ID: <20060718194621.3079b217@home.brethil>
In-Reply-To: <jeu05e4n3w.fsf@sykes.suse.de>
References: <44BC5A3F.2080005@stanford.edu>
	<20060718181631.13f6f052@doriath.conectiva>
	<jeu05e4n3w.fsf@sykes.suse.de>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2006 23:30:43 +0200
Andreas Schwab <schwab@suse.de> wrote:

| "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> writes:
| 
| > On Mon, 17 Jul 2006 20:49:19 -0700
| > Thomas Dillig <tdillig@stanford.edu> wrote:
| >
| > | [4]
| > | 239 drivers/usb/misc/usblcd.c
| > | NULL dereference of variable "urb".
| >
| >  This is a false positive.
| 
| It is not, for 2.6.17. But the bug has already been fixed some time ago.

 Wooops. Very true. Looked in current Linus' tree. Sorry for that.

-- 
Luiz Fernando N. Capitulino
