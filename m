Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTJXLit (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 07:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbTJXLit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 07:38:49 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:1962 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262153AbTJXLis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 07:38:48 -0400
Message-Id: <200310241136.NAA30555@fire.malware.de>
Date: Fri, 24 Oct 2003 13:38:23 +0200
From: malware@t-online.de (Michael Mueller)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: mj@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: [2.4] PCI chipset Opti Viper M/N+
References: <200310240956.h9O9uDK27733@winbloz.malware.de> <md5:FBD343F3435F79857BDF1297AFE82D42>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: Ekxy8rZGweC0Nn3Mahq7ihqaGMul4scYn1VD3s2VAXJqzBSoXMM9rm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin and linux-kernel readers,

I wrote:
> it should read:
>    val |= newval << (3*(pirq-1));
> 
> With this changed it still works with the PCMCIA card, but I still need
> to gain access to a CardBus card to test it with.

Ok, tested it with a LevelOne 10/100MBit CardBus card in a local
computer store. It works fine.


Michael

-- 
Linux@TekXpress
http://www-users.rwth-aachen.de/Michael.Mueller4/tekxp/tekxp.html
