Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262355AbUKDTMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbUKDTMD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbUKDTIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:08:46 -0500
Received: from canuck.infradead.org ([205.233.218.70]:9991 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262355AbUKDTFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:05:32 -0500
Subject: Re: QM_MODULES not implemented in 2.6.9
From: Arjan van de Ven <arjan@infradead.org>
To: yiding_wang@agilent.com
Cc: linux-kernel@vger.kernel.org, Yidng_wang@agilent.com
In-Reply-To: <08A354A3A9CCA24F9EE9BE13600CFBC50F3AE3@wcosmb07.cos.agilent.com>
References: <08A354A3A9CCA24F9EE9BE13600CFBC50F3AE3@wcosmb07.cos.agilent.com>
Content-Type: text/plain
Message-Id: <1099595121.16640.21.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 04 Nov 2004 20:05:21 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-04 at 10:57 -0800, yiding_wang@agilent.com wrote:
> I noticed that this issue was there before but thought it was being taken care of since my Linux-2.6.2 kernel did not complain. Now I loaded Linux-2.6.9 and this QM_MODULES Function not implemented error pops up whenever I run module related command.
> 
> If I need update module patch, could someone tell which module patch I should apply? If something else is wrong, please advice. The kernel is configured to support module.

you need to use a 2.6 compatible modutils....


