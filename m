Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266338AbUFXRav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266338AbUFXRav (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 13:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266738AbUFXRaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 13:30:46 -0400
Received: from host61.200-117-131.telecom.net.ar ([200.117.131.61]:39628 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S266338AbUFXR2s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 13:28:48 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm2
Date: Thu, 24 Jun 2004 14:28:42 -0300
User-Agent: KMail/1.6.2
References: <20040624014655.5d2a4bfb.akpm@osdl.org> <20040624033321.7366ac67.akpm@osdl.org>
In-Reply-To: <20040624033321.7366ac67.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406241428.42330.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> OK, ACPI seems to have progressed in a non-forward direction here.
>
> If anyone has weird problems, please do a `patch -p1 -R' of
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-m
>m2/broken-out/bk-acpi.patch

Thanks Andrew. ov511 wasn't coming up. I did the above patch and everything 
works :-)

Regards,
Norberto
