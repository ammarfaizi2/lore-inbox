Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267357AbUHDRTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267357AbUHDRTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 13:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267339AbUHDRTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 13:19:47 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:33740 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S267357AbUHDRTq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 13:19:46 -0400
Date: Wed, 4 Aug 2004 19:16:46 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Realtek 8169 NIC driver version
Message-ID: <20040804191646.A27806@electric-eye.fr.zoreil.com>
References: <1677288031.20040803142517@yahoo.com.cn> <20040803093606.A4911@electric-eye.fr.zoreil.com> <411114E6.2060407@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <411114E6.2060407@myrealbox.com>; from luto@myrealbox.com on Wed, Aug 04, 2004 at 09:55:02AM -0700
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@myrealbox.com> :
[...]
> This one bit me awhile back, too.  Could we just remove that version 
> number?  (Especially with the latest round of changes, the in-kernel 
> driver bears little resemblance to Realtek's.)

A patch has been sent to Jeff. If someone wants to see it before it's in
Jeff's -netdev or -mm, it is available at:
http://www.fr.zoreil.com/people/francois/misc/r8169-40.patch

--
Ueimor
