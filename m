Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422791AbWHZGdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422791AbWHZGdJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 02:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422884AbWHZGdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 02:33:09 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:24765 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1422791AbWHZGdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 02:33:08 -0400
Date: Sat, 26 Aug 2006 08:32:47 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       schwidefsky@de.ibm.com
Subject: Re: [PATCH 1/3] kthread: update s390 cmm driver to use kthread
Message-ID: <20060826063247.GA6928@osiris.boeblingen.de.ibm.com>
References: <20060824212241.GB30007@sergelap.austin.ibm.com> <20060825143842.GA27364@infradead.org> <20060825200359.GC13805@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825200359.GC13805@sergelap.austin.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> below patch on top of -mm2 is wrong (it compiles, but I just noticed
> 2.6.18-rc4-mm2 doesn't boot without this patch either) but hopefully

2.6.18-rc4-mm2 works fine for me. What configuration and machine setup did
you use?
