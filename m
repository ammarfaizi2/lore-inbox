Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263589AbTEDM2s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 08:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTEDM2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 08:28:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15321 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263589AbTEDM2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 08:28:48 -0400
Date: Sun, 04 May 2003 04:34:11 -0700 (PDT)
Message-Id: <20030504.043411.78711825.davem@redhat.com>
To: paulus@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module owners for ppp compressors
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <16053.2247.905824.83736@argo.ozlabs.ibm.com>
References: <16053.2247.905824.83736@argo.ozlabs.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Paul Mackerras <paulus@samba.org>
   Date: Sun, 4 May 2003 22:34:15 +1000
   
   The patch below cleans up the module refcounting for the PPP
   compressor modules, i.e., ppp_deflate.c and bsd-comp.c.
 ...   
   Please send this on to Linus if you think it is OK.

Looks good, I'll push this along.

Thanks.
