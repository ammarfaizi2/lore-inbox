Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262640AbVBYHdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbVBYHdh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 02:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbVBYHdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 02:33:37 -0500
Received: from moutng.kundenserver.de ([212.227.126.189]:30972 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262640AbVBYHcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 02:32:46 -0500
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 05/12] acpi: sleep-while-atomic during S3 resume from ram
Date: Fri, 25 Feb 2005 08:32:45 +0100
User-Agent: KMail/1.7.1
Cc: akpm@osdl.org, len.brown@intel.com, acpi-devel@lists.sourceforge.net
References: <200502230953.j1N9rFj1020702@shell0.pdx.osdl.net>
In-Reply-To: <200502230953.j1N9rFj1020702@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502250832.46209.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org wrote:
> From: Christian Borntraeger <linux-kernel@borntraeger.net>
>
> During the wakeup from suspend-to-ram I get several warnings.
>
> Signed-off-by: Christian Borntraeger <linux-kernel@borntraeger.net>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

Andrew,

Len told me that he is going to solve the issue in a different and better 
way.

cheers

Christian
