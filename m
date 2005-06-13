Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVFMQCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVFMQCm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 12:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVFMQCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 12:02:42 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:51479 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261634AbVFMQCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 12:02:38 -0400
Subject: Re: [RFC] Observations on x86 process.c
From: Ian Campbell <ijc@hellion.org.uk>
To: cutaway@bellsouth.net
Cc: Denis Vlasenko <vda@ilport.com.ua>, linux-kernel@vger.kernel.org
In-Reply-To: <000a01c57035$79738a80$2800000a@pc365dualp2>
References: <002301c57018$266079b0$2800000a@pc365dualp2>
	 <200506131618.09718.vda@ilport.com.ua>
	 <000a01c57035$79738a80$2800000a@pc365dualp2>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 17:02:30 +0100
Message-Id: <1118678551.23816.3.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 12:32 -0400, cutaway@bellsouth.net wrote:
> Where __attribute__((slowcode)) is defined in some macro.

I think you should probably checkout the likely() and unlikely() macros
which are already defined for use in the kernel.
Ian.

-- 
Ian Campbell
Current Noise: Metallica - Fuel

When the cup is full, carry it level.

