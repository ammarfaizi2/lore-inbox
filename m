Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbVHHReH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVHHReH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbVHHReH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:34:07 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:33259 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932136AbVHHReG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:34:06 -0400
Subject: Re: 2.6.13-rc5-mm1 doesnt boot on x86_64
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andi Kleen <ak@muc.de>
Cc: Ashok Raj <ashok.raj@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050808171126.GA32092@muc.de>
References: <20050808094818.A17579@unix-os.sc.intel.com>
	 <20050808171126.GA32092@muc.de>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 12:33:29 -0500
Message-Id: <1123522409.5019.0.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-08 at 19:11 +0200, Andi Kleen wrote:
> Looks like a SCSI problem. The machine has an Adaptec SCSI adapter, right?

The traceback looks pretty meaningless.

What was happening on the machine before this.  i.e. was it booting up,
in which case can we have the prior dmesg file; or was the aic79xxx
driver being removed?

James


