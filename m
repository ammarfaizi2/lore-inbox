Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVCINRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVCINRD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 08:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbVCINRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 08:17:02 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49386 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261619AbVCINQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 08:16:57 -0500
Subject: Re: Problem with DCE with Kernel Patch
From: Arjan van de Ven <arjan@infradead.org>
To: "Singal, Manoj Kumar (STSD)" <manoj-kumar.singal@hp.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3EB96D97711EAA45B291A31082CC865601511595@bgeexc04.asiapacific.cpqcorp.net>
References: <3EB96D97711EAA45B291A31082CC865601511595@bgeexc04.asiapacific.cpqcorp.net>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 14:16:48 +0100
Message-Id: <1110374209.6280.102.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 18:21 +0530, Singal, Manoj Kumar (STSD) wrote:
> Hello,
> 
> While installing DCE 0.1.13 on RH Linux AS 2.1 Kernel 2.4.18-e.54smp
> running on Itanium, the system hangs and becomes unbootable. It then has
> to be started in single user mode, the dce rpm has to be removed and
> then booted. This happens with kernel patch 52/54. 
> 
> Has anyone faced a similar problem and resolved it ? . Any pointers in
> this regard will be really *nice*

you are probably better off using the support escalation person to RH
inside HP for such issues; the 2.4.18 kernel is ancient and of little
interest to lkml generally.


