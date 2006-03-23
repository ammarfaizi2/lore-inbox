Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422718AbWCWWeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422718AbWCWWeN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422720AbWCWWeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:34:12 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:22980 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S1422718AbWCWWeK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:34:10 -0500
From: Francesco Biscani <biscani@pd.astro.it>
To: "Yu, Luming" <luming.yu@intel.com>
Subject: Re: ACPI error in 2.6.16 (AE_TIME, Returned by Handler for EmbeddedControl)
Date: Thu, 23 Mar 2006 23:34:03 +0100
User-Agent: KMail/1.9.1
Cc: "Brown, Len" <len.brown@intel.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
References: <3ACA40606221794F80A5670F0AF15F840B468EFD@pdsmsx403>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840B468EFD@pdsmsx403>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603232334.04717.biscani@pd.astro.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 March 2006 04:46, Yu, Luming wrote:
> Please file this bug on bugzilla.kernel.org
> We need to find out why ?
> Could you post dmesg for ec_intr=0 , ec_intr=1 on bugzilla.

Done:

http://bugzilla.kernel.org/show_bug.cgi?id=6278

Thanks,

  Francesco


-- 
Dr. Francesco Biscani
Dipartimento di Astronomia
Università di Padova
biscani@pd.astro.it
