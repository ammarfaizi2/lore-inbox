Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUFENTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUFENTT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 09:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUFENTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 09:19:18 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:8842 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S261347AbUFENTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 09:19:16 -0400
Message-ID: <40C1C84F.5070203@stanchina.net>
Date: Sat, 05 Jun 2004 15:19:11 +0200
From: Flavio Stanchina <flavio@stanchina.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: dual_bereta_r0x <dual_bereta_r0x@arenanetwork.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6 Kernel Oops and ATI 3.9.0 proprietary driver
References: <40C0AC7D.6040304@arenanetwork.com.br>
In-Reply-To: <40C0AC7D.6040304@arenanetwork.com.br>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dual_bereta_r0x wrote:
> More info on request.

I'm sorry but only ATI can help you: the oops is in the binary-only part 
of the driver. You should have asked ATI and not us in the first place 
anyway, but this is one more reason to do so.

FWIW, try again after disabling CONFIG_REGPARM, but do *not* send email 
to linux-kernel if it still doesn't work.

-- 
Ciao, Flavio

