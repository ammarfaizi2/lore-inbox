Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264920AbUFVPvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264920AbUFVPvp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264827AbUFVPuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:50:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:36579 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264973AbUFVPqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:46:18 -0400
Date: Tue, 22 Jun 2004 08:46:07 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Catalin BOIE <util@deuroconsult.ro>
Cc: netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, lartc@mailman.ds9a.nl
Subject: Re: [LARTC] [ANNOUNCE] sch_ooo - Out-of-order packet queue
 discipline
Message-Id: <20040622084607.4996569f@dell_ss3.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.58.0404021023140.18886@hosting.rdsbv.ro>
References: <Pine.LNX.4.58.0404021023140.18886@hosting.rdsbv.ro>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe the delay and ooo scheduler should be merged, the both do sort of
the same thing.
