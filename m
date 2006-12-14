Return-Path: <linux-kernel-owner+w=401wt.eu-S1751842AbWLNKTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbWLNKTe (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 05:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751843AbWLNKTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 05:19:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53617 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbWLNKTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 05:19:33 -0500
Subject: Re: Userspace I/O driver core
From: Arjan van de Ven <arjan@infradead.org>
To: Avi Kivity <avi@argo.co.il>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <45811D0F.2070705@argo.co.il>
References: <20061214010608.GA13229@kroah.com> <45811D0F.2070705@argo.co.il>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 14 Dec 2006 11:19:30 +0100
Message-Id: <1166091570.27217.983.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I understand one still has to write a kernel driver to shut up the irq.  
> How about writing a small bytecode interpreter to make event than 
> unnecessary?

if you do that why not do a real driver.


