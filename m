Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269489AbTCDOU3>; Tue, 4 Mar 2003 09:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269490AbTCDOU3>; Tue, 4 Mar 2003 09:20:29 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:2464
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S269489AbTCDOU2>; Tue, 4 Mar 2003 09:20:28 -0500
Subject: Re: eepro100 ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030304141109.GI646@rdlg.net>
References: <20030304141109.GI646@rdlg.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046792123.10855.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 04 Mar 2003 15:35:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-04 at 14:11, Robert L. Harris wrote:
> in my dmesg log.  Out of curiosity I tried with the alternate driver and
> that seems to have gone away.  Is one depreciated or are they both
> viable and just different?   The help message doesn't really say much on
> the topic.
> 
> < >     EtherExpressPro/100 support (eepro100, original Becker driver)
> < >     EtherExpressPro/100 support (e100, Alternate Intel driver)

e100 is intels own driver which was initially proprietary but has since been
cleaned up a lot and relicensed GPL, then merged with the kernel. The e100
driver is probably the best driver to be using nowdays although both should
work reliably

