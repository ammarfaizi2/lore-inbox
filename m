Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267298AbUJNSkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267298AbUJNSkP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUJNSbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:31:25 -0400
Received: from moutng.kundenserver.de ([212.227.126.176]:23501 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266884AbUJNRuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 13:50:18 -0400
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc4-mm1
Date: Thu, 14 Oct 2004 19:50:11 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20041011032502.299dc88d.akpm@osdl.org> <416E03CD.8080701@jp.fujitsu.com> <20041013215049.7ccd73ae.akpm@osdl.org>
In-Reply-To: <20041013215049.7ccd73ae.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410141950.12199.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Well I can tell just from looking at it that the patch is
> whitespace-mangled.  It seems that a quarter of the patches I get
> nowadays are unusable due to this.  What's going on out there?

I cannot explain this case, but I can at least explain all KMAIL tab/space 
mangles. The current qt 3.3.3 version has a bug which is fixed in the 
current qt snapshot. 

Every kmail user should be aware of that 
see 
http://bugs.kde.org/show_bug.cgi?id=90688
for further details.

There is another problem that "cat diff-file + X copy and paste" does 
convert all tabs as well. 

cheers

Christian
