Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754362AbWKMJvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362AbWKMJvg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 04:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754368AbWKMJvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 04:51:36 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:37786 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1754362AbWKMJvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 04:51:35 -0500
Subject: Re: [PATCH 2.6.19-rc5-git2] EFI: calling efi_get_time during
	suspend
From: Arjan van de Ven <arjan@linux.intel.com>
To: "Myaskouvskey, Artiom" <artiom.myaskouvskey@intel.com>
Cc: davej@codemonkey.org.uk, hpa@zytor.com, linux-kernel@vger.kernel.org,
       "Satt, Shai" <shai.satt@intel.com>
In-Reply-To: <C1467C8B168BCF40ACEC2324C1A2B07401704459@hasmsx411.ger.corp.intel.com>
References: <C1467C8B168BCF40ACEC2324C1A2B07401704459@hasmsx411.ger.corp.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Nov 2006 10:51:27 +0100
Message-Id: <1163411487.15249.116.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 11:43 +0200, Myaskouvskey, Artiom wrote:
> From: Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>

Hi,

> - * This should only be used during kernel init and before runtime
> - * services have been remapped, therefore, we'll need to call in
> physical
> - * mode.  Note, this call isn't used later, so mark it __init.


unfortunately your patch is word wrapped; please try using an email
program that does not wrap emails (or worst case, try using attachments
instead, but those are horrible in terms of patch review)

Greetings,
   Arjan van de Ven
