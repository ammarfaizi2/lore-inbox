Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268850AbUHLWtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268850AbUHLWtd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 18:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268864AbUHLWrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 18:47:14 -0400
Received: from mail5.tpgi.com.au ([203.12.160.101]:1159 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S268850AbUHLWqt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:46:49 -0400
Subject: Re: [PATCH] SCSI midlayer power management
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nathan Bryant <nbryant@optonline.net>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <1092350198.24737.19.camel@laptop.cunninghams>
References: <4119611D.60401@optonline.net>
	 <20040811080935.GA26098@elf.ucw.cz> <411A1B72.1010302@optonline.net>
	 <1092231462.2087.3.camel@mulgrave> <1092267400.2136.24.camel@gaston>
	 <1092314892.1755.5.camel@mulgrave> <20040812131457.GB1086@elf.ucw.cz>
	 <1092328173.2184.15.camel@mulgrave>  <20040812191120.GA14903@elf.ucw.cz>
	 <1092339247.1755.36.camel@mulgrave>
	 <1092350198.24737.19.camel@laptop.cunninghams>
Content-Type: text/plain
Message-Id: <1092350607.24776.24.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 13 Aug 2004 08:43:27 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy again.

On Fri, 2004-08-13 at 08:36, Nigel Cunningham wrote:
> I'm not pretending to understand the issues you're talking about, but I
> do have a question that might possibly be helpful: Pages can be marked
> with the Nosave flag, so that they're not saved in the image and not
> overwritten when we copy the old kernel back. Would using Nosave help
> here at all?

Having read the rest of the thread, I can see that's probably not
helpful :>

Nigel
-- 
Nigel Cunningham
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. But true tolerance can cope with others
being intolerant.

