Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVCRXay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVCRXay (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 18:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVCRX2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 18:28:52 -0500
Received: from fire.osdl.org ([65.172.181.4]:1252 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262108AbVCRX2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 18:28:41 -0500
Date: Fri, 18 Mar 2005 15:28:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.6.10 (EIP is at hid_init_reports+0x151/0x1d0
 [usbhid])
Message-Id: <20050318152819.102e71bf.akpm@osdl.org>
In-Reply-To: <20050318160554.GY6542@charite.de>
References: <20050318160554.GY6542@charite.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could you please test 2.6.11 or, even better, 2.6.12-rc1?
