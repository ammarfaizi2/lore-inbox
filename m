Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbVAEFQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbVAEFQb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 00:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVAEFQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 00:16:31 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:58552 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262245AbVAEFQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 00:16:29 -0500
Subject: Re: How to write elegant C coding
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: krishna <krishna.c@globaledgesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <lkml@kolivas.org>
In-Reply-To: <41DB6248.2030003@globaledgesoft.com>
References: <41DB5E83.4080000@globaledgesoft.com>
	 <41DB6210.4030007@kolivas.org>  <41DB6248.2030003@globaledgesoft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104898308.24896.158.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 05 Jan 2005 04:11:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-01-05 at 03:43, krishna wrote:
> What I mean is both elegant and _efficient_ best practices in C coding.

Documentation/CodingStyle is well worth a read. Also for that matter
just reading a lot of good code helps you write good code as reading
helps you learn a language better.

Efficiency is a harder subject: Remember that efficient code still must
be easy to understand so often is about algorithms not language, and in
part about hardware.

On the hardware side - the book "Unix systems for modern architectures"

But as Tim righly said "practice"

Alan

