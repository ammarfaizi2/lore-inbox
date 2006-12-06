Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760267AbWLFGn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760267AbWLFGn2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 01:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760268AbWLFGn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 01:43:28 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:30632 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760267AbWLFGn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 01:43:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:reply-to:x-priority:message-id:to:cc:subject:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=dp5u26k/ZS2H7V0Hf0I90Y4Jk8fM+EYr7X+HUPzlNSH2kY/+xkejRsjWnqFiw9U8ATRbSwp/U+7qdIYGRGUQQxKN4n9cNItcTW9j+/7fbbPNSffUuXEyDFgHjXXZhoBVi+jmokfoi8lHGYpn5Y2/f2HZaKMgK4wdZsxfDN2RHIM=
Date: Wed, 6 Dec 2006 08:43:28 +0200
From: Paul Sokolovsky <pmiscml@gmail.com>
Reply-To: Paul Sokolovsky <pmiscml@gmail.com>
X-Priority: 3 (Normal)
Message-ID: <582252003.20061206084328@gmail.com>
To: Lennert Buytenhek <buytenh@wantstofly.org>
CC: "Michael K. Edwards" <medwards.linux@gmail.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>,
       <linux-arm-toolchain@lists.arm.linux.org.uk>,
       <linux-arm-kernel@lists.arm.linux.org.uk>, <crossgcc@sourceware.org>
Subject: Re[2]: More ARM binutils fuckage
In-Reply-To: <20061206010813.GC30401@xi.wantstofly.org>
References: <20061205193357.GF24038@flint.arm.linux.org.uk> <f2b55d220612051529t3c0dcda8ma920c13b00899b10@mail.gmail.com> <20061206002226.GK24038@flint.arm.linux.org.uk> <20061206010813.GC30401@xi.wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lennert,

Wednesday, December 6, 2006, 3:08:13 AM, you wrote:

[]
> (These
> days I build all kernels in EABI mode with old-ABI compat.)  I have
> not run into any code generation issues with this compiler yet.

  I wonder, if OABI-compat is known to actually work on OABI userspace,
I mean, on something real, like xserver-kdrive ;-). Because I'd really
like to build single kernel for both old and new userspace too, but
afraid to try that, fearing to be put down by another broken feature
;-).


-- 
Best regards,
 Paul                            mailto:pmiscml@gmail.com

