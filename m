Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbUKABQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbUKABQU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 20:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbUKABQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 20:16:20 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:18877 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261776AbUKABQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 20:16:11 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Map extra keys on compaq evo
Date: Sun, 31 Oct 2004 20:16:08 -0500
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@suse.cz>, vojtech@suse.cz
References: <20041031213859.GA6742@elf.ucw.cz>
In-Reply-To: <20041031213859.GA6742@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410312016.08468.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 31 October 2004 04:38 pm, Pavel Machek wrote:
> Hi!
> 
> Compaq Evo notebooks seem to use non-standard keycodes for their extra
> keys. I workaround that quirk with dmi hook.
> 

Why don't you just call "setkeycodes" from your init script?

-- 
Dmitry
