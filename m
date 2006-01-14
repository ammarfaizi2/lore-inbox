Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751760AbWANOtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbWANOtk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 09:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbWANOtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 09:49:40 -0500
Received: from relay4.usu.ru ([194.226.235.39]:32656 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1751758AbWANOtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 09:49:40 -0500
Message-ID: <43C90FC1.6020200@ums.usu.ru>
Date: Sat, 14 Jan 2006 19:50:41 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kay Sievers <kay.sievers@suse.de>
Cc: Greg K-H <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] INPUT: add MODALIAS to the event environment
References: <11371818082670@kroah.com> <11371818084013@kroah.com> <43C88898.10900@ums.usu.ru> <20060114110401.GA11237@vrfy.org> <43C8F962.9030409@ums.usu.ru> <20060114132138.GA12273@vrfy.org> <43C8FFD7.3030408@ums.usu.ru> <20060114141135.GA12581@vrfy.org>
In-Reply-To: <20060114141135.GA12581@vrfy.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.0.27; VDF: 6.33.0.123; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Sievers wrote:

>Do you have any subsystem left, that could
>support modalias, but doesn't?
>  
>
Probably not. On my system, udev loads every module it should.

-- 
Alexander E. Patrakov
