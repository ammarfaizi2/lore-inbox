Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVGTLBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVGTLBR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 07:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVGTLBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 07:01:17 -0400
Received: from [81.2.110.250] ([81.2.110.250]:33408 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261155AbVGTLBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 07:01:16 -0400
Subject: Re: assignment of major number to serial driver -2.6.x kernels
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "V. ANANDA KRISHNAN" <mansarov@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1121788393.3756.8.camel@siliver.austin.ibm.com>
References: <1121788393.3756.8.camel@siliver.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Jul 2005 12:25:10 +0100
Message-Id: <1121858710.11024.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-07-19 at 10:53 -0500, V. ANANDA KRISHNAN wrote:
>   Also I would like to know the procedure (and related info) to apply
> for getting a static number (major/minor) for devices in device drivers.
> Is this practice continued still?

If you want device nodes you still need device numbers (www.lanana.org)

