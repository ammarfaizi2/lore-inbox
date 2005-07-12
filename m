Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbVGLWnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbVGLWnc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbVGLWY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:24:27 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:47586 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S262475AbVGLWWr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:22:47 -0400
Subject: Re: [PATCH 0/29v2] InfiniBand core update
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org, rolandd@cisco.com
In-Reply-To: <20050711201117.72539977.akpm@osdl.org>
References: <1121110249.4389.4984.camel@hal.voltaire.com>
	 <20050711170548.31605e23.akpm@osdl.org>
	 <1121136330.4389.5093.camel@hal.voltaire.com>
	 <20050711201117.72539977.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1121206549.4382.10.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Jul 2005 18:15:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 23:11, Andrew Morton wrote:
> Well I was asking.  Do you guys think that this material is appropriate to
> and safe enough for 2.6.13?

I used your versions of the patches (Tom's ucm one is needed and you
added that). I also back ported the trailing whitespace elimination
changes.

I just completed a regression test including uCM, CM, RMPP, OpenSM,
IPoIB and it looks good to me.

I'll check this again when the next -mm comes out.

Thanks.

-- Hal

