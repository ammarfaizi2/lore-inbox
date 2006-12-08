Return-Path: <linux-kernel-owner+w=401wt.eu-S1760832AbWLHSgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760832AbWLHSgv (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 13:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760833AbWLHSgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:36:51 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47229 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760832AbWLHSgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:36:50 -0500
Date: Fri, 8 Dec 2006 10:35:57 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Divy Le Ray <divy@chelsio.com>
Cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/10] cxgb3: Chelsio T3 1G/10G ethernet device driver
Message-ID: <20061208103557.38c3dd9b@localhost>
In-Reply-To: <4578DB2F.4010204@chelsio.com>
References: <4578DB2F.4010204@chelsio.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor style stuff (that can be fixed later).
1) /* C style comments */ are preferred over // C++ style
2) Please use C99 style structure initializers especially for OS
   interface structures like ops for MII.
