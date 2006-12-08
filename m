Return-Path: <linux-kernel-owner+w=401wt.eu-S1426061AbWLHTKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426061AbWLHTKE (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 14:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426071AbWLHTKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 14:10:03 -0500
Received: from smtp.osdl.org ([65.172.181.25]:50530 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426061AbWLHTKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 14:10:00 -0500
Date: Fri, 8 Dec 2006 11:08:41 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Divy Le Ray <None@chelsio.com>
Cc: jeff@garzik.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/10] cxgb3 - scatter gather engine
Message-ID: <20061208110841.6dc27120@localhost>
In-Reply-To: <20061208032725.8538.60025.stgit@localhost.localdomain>
References: <20061208032725.8538.60025.stgit@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The NAPI code in the cxgb2 driver was a mess (see patch today), don't know if
cxgb3 could use the similar brain surgery..


