Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310686AbSCHFrH>; Fri, 8 Mar 2002 00:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310691AbSCHFq6>; Fri, 8 Mar 2002 00:46:58 -0500
Received: from DIRTY-BASTARD.MIT.EDU ([18.241.0.136]:7296 "EHLO
	dirty-bastard.pthbb.org") by vger.kernel.org with ESMTP
	id <S310686AbSCHFqq>; Fri, 8 Mar 2002 00:46:46 -0500
Date: Fri, 8 Mar 2002 18:39:51 GMT
From: Jerrad Pierce <belg4mit@dirty-bastard.pthbb.org>
Message-Id: <200203081839.g28Idp000915@dirty-bastard.pthbb.org>
To: linux-kermel@vger.kernel.org
Subject: 2.4.18 prob's WAS Tulip bug?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--------
There is no Documentation/networking/tulip.txt which is referenced in that
directory's 00-INDEX and also in the long explanation for the Tulip entry
in menuconfig.

I have upgraded to 2.4.18 and am still experiencing these kernel panics,
they seem to be exacerbated by compiling...

I have placed the most recent ksymoops dump and the current kernel config
at http://mit.edu/belg4mit/Public/kernel/

Thanks!
