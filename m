Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVBZTdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVBZTdB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 14:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVBZTdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 14:33:01 -0500
Received: from smtpout4.uol.com.br ([200.221.4.195]:11411 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261248AbVBZTc6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 14:32:58 -0500
Date: Sat, 26 Feb 2005 16:32:55 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Brian Kuschak <bkuschak@yahoo.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] Re: 2.6.11-rc4 libata-core (irq 30: nobody cared!)
Message-ID: <20050226193255.GA6256@ime.usp.br>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Brian Kuschak <bkuschak@yahoo.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
References: <20050224015859.55191.qmail@web40910.mail.yahoo.com> <421D3D33.9060707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <421D3D33.9060707@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 23 2005, Jeff Garzik wrote:
> Does this patch do anything useful?
> 	Jeff
(...)

The patch you posted seems to only affect people using SATA, right?

BTW, just for clarity I'm seeing the message in a PATA environment (on
i386) and Brian is seeing his problem with a SATA device on ppc.


Thanks, Rogério Brito.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
