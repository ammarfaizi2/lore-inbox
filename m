Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422656AbWBVTwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422656AbWBVTwc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 14:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422658AbWBVTwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 14:52:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47017 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422656AbWBVTwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 14:52:31 -0500
Date: Wed, 22 Feb 2006 11:51:59 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Brian Hall <brihall@pcisys.net>
Cc: Willy Tarreau <willy@w.ods.org>, Greg KH <greg@kroah.com>,
       Sergey Vlasov <vsu@altlinux.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Help: DGE-560T not recognized by Linux
Message-ID: <20060222115159.103987c1@localhost.localdomain>
In-Reply-To: <20060222035100.GA6174@pcisys.net>
References: <20060217222720.a08a2bc1.brihall@pcisys.net>
	<20060217222428.3cf33f25.akpm@osdl.org>
	<20060218003622.30a2b501.brihall@pcisys.net>
	<20060217234841.5f2030ec.akpm@osdl.org>
	<20060218100126.198d86c3.brihall@pcisys.net>
	<20060218222946.4da27618.vsu@altlinux.ru>
	<20060218163555.39fa3b4a@localhost.localdomain>
	<20060219010441.GA5810@kroah.com>
	<20060220114341.GA7710@w.ods.org>
	<20060222035100.GA6174@pcisys.net>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just posted a bunch of patches to netdev, one of them is the one to
workaround/avoid pci_config issues.
