Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWDHVKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWDHVKo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 17:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWDHVKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 17:10:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:35824 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751434AbWDHVKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 17:10:43 -0400
From: Hans-Peter Jansen <hpj@urpla.net>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Subject: Re: Linux 2.6.17-rc1
Date: Sat, 8 Apr 2006 23:10:21 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <20060404080205.C8B29E007A12@knarzkiste.dyndns.org> <20060403202539.65cf6e33.akpm@osdl.org> <20060404080529.GM7849@charite.de>
In-Reply-To: <20060404080529.GM7849@charite.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604082310.22079.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:18d01dd0a2a377f0376b761557b5e99a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 4. April 2006 10:05 schrieb Ralf Hildebrandt:
>
> I added the patch.
>
> [...]
>
> So, no more EIPs, but no conclusive messages either!

Just for the record:
Ralf, if I'm not completely mistaken, EIP just means Extended 
Instruction Pointer, which names a single cpu internal register per 
core pointing to the next instruction to execute. So better keep it ;-)

Pete
