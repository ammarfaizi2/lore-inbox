Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751842AbWEPQG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbWEPQG4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbWEPQG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:06:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4536 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751842AbWEPQGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:06:55 -0400
Date: Tue, 16 May 2006 09:03:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: dtor_core@ameritech.net, vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] add input_enable_device()
Message-Id: <20060516090324.66ea0ea6.akpm@osdl.org>
In-Reply-To: <4469F709.4040605@aknet.ru>
References: <44670446.7080409@aknet.ru>
	<20060515143119.54b5aff8.akpm@osdl.org>
	<4469F709.4040605@aknet.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev <stsp@aknet.ru> wrote:
>
> add input_enable_device() and input_disable_device()
> 
>  Signed-off-by: Stas Sergeev <stsp@aknet.ru>
>  CC: Dmitry Torokhov <dtor_core@ameritech.net>
>  CC: Vojtech Pavlik <vojtech@suse.cz>

uh, that's not a complete changelog - it describes what the code does
(which is obvious), but doesn't describe why it does it.

iirc it had to do with the pc-speaker driver, but I don't seem to be able
to locate the original email.

