Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269156AbUIBWzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269156AbUIBWzC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269185AbUIBWwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:52:50 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:40423 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S269235AbUIBWtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:49:17 -0400
From: "David B. Stevens" <dsteven3@maine.rr.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: Kernel or Grub bug.
Date: Thu, 2 Sep 2004 18:53:32 -0400
User-Agent: KMail/1.6.2
Cc: "Wise, Jeremey" <jeremey.wise@agilysys.com>, linux-kernel@vger.kernel.org
References: <200409022103.i82L2rm1003486@laptop11.inf.utfsm.cl>
In-Reply-To: <200409022103.i82L2rm1003486@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200409021853.32250.dsteven3@maine.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 September 2004 17:02, Horst von Brand wrote:
> "Wise, Jeremey" <jeremey.wise@agilysys.com> said:
>
> [...]
>
> > My system is all reiserfs though the Fedora core box I also did testing
> > on was EXT3.
>
> grub can't handle ReiserFS.

Which is probably one of the reasons why SuSE uses a RAMDISK with an EXT2 
image to start Reiserfs based systems.

Jeremey take a look at the SuSE boot sequence the first root filesystem is 
EXT2 and it is a RAMDISK.

Cheers,
  Dave

 
