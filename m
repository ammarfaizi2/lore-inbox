Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266535AbUHBNyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266535AbUHBNyt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 09:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbUHBNys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 09:54:48 -0400
Received: from imap.gmx.net ([213.165.64.20]:39332 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266535AbUHBNyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 09:54:33 -0400
X-Authenticated: #240349
From: Erich Focht <efocht@gmx.net>
To: "Aneesh Kumar K.V" <aneesh.kumar@hp.com>
Subject: Re: [SSI-devel] Re: [ANNOUNCE] OpenSSI 1.0.0 released!!
Date: Mon, 2 Aug 2004 15:50:39 +0200
User-Agent: KMail/1.6.2
Cc: ssic-linux-devel@lists.sourceforge.net, Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-cluster@redhat.com
References: <2o0e0-6qx-5@gated-at.bofh.it> <m37jsk42hw.fsf@averell.firstfloor.org> <410DDFA2.40107@hp.com>
In-Reply-To: <410DDFA2.40107@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408021550.39219.efocht@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 August 2004 08:30, Aneesh Kumar K.V wrote:
> > [....] Congratulations. But I was a bit disappointed that there
> > wasn't a tarball with the kernel patches and other sources.
> > Any chance to add that to the site? 
> 
> I have posted  the diff at
> http://www.openssi.org/contrib/linux-ssi.diff.gz

Hmmm, that's too huge to get an overview on what it does...
The current CVS ci/kernel touches 137 files, openssi/kernel touches
350 files. Plus the ci/kernel.patches and openssi/kernel.patches...

> For 2.6 we are planning to group the changes into small patches that is 
>   easy to review.

Sounds great! Having groups sorted by functionality will help a
lot. When will these be visible in the CVS?

Thanks,
best regards,
Erich



