Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263791AbTFLVwO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 17:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265018AbTFLVwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 17:52:14 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:52635 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263791AbTFLVwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 17:52:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16104.63811.690286.78565@gargle.gargle.HOWL>
Date: Fri, 13 Jun 2003 00:05:55 +0200
From: mikpe@csd.uu.se
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Subject: Re: [PATCH] Fix perfctr on x86_64
In-Reply-To: <1055454843.1043.21.camel@serpentine.internal.keyresearch.com>
References: <1055454843.1043.21.camel@serpentine.internal.keyresearch.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan O'Sullivan writes:
 > Mikael -
 > 
 > One of Andi's pre-2.5.70 x86_64 merges converted the x86_64 APIC code to
 > using the new driver model.  This patch against perfctr-2.5.4 fixes the
 > kernel portion of the perfctr build.

Thanks. Did this happen in 2.5.70 or 2.5.70-bk? I don't remember
seeing this change in the vanilla 2.5.70.

/Mikael
