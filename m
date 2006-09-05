Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWIESSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWIESSQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 14:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbWIESSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 14:18:16 -0400
Received: from khc.piap.pl ([195.187.100.11]:40930 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1030184AbWIESSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 14:18:14 -0400
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18rc5: NFSd possible recursive locking
References: <m3slj8ae84.fsf@defiant.localdomain>
	<1157436733.14324.9.camel@twins>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 05 Sep 2006 20:18:11 +0200
In-Reply-To: <1157436733.14324.9.camel@twins> (Peter Zijlstra's message of "Tue, 05 Sep 2006 08:12:13 +0200")
Message-ID: <m3mz9eb2jg.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <a.p.zijlstra@chello.nl> writes:

> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/broken-out/nfsd-lockdep-annotation.patch
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/broken-out/knfsd-nfsd-lockdep-annotation-fix.patch
>
> Do those patches fix it?

I think so. And NFS server still works :-)
-- 
Krzysztof Halasa
