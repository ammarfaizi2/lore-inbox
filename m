Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263646AbUDUTZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbUDUTZK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 15:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263648AbUDUTZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 15:25:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:11669 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263646AbUDUTZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 15:25:03 -0400
Date: Wed, 21 Apr 2004 12:19:10 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: FabF <Fabian.Frederick@skynet.be>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.6-rc2-mm1] autofs parser simplified
Message-Id: <20040421121910.701e1907.rddunlap@osdl.org>
In-Reply-To: <1082574046.1847.2.camel@bluerhyme.real3>
References: <1082574046.1847.2.camel@bluerhyme.real3>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2004 21:00:47 +0200 FabF wrote:

| Andrew,
| 
| 	Here's a patch to avoid int parse redundancy in autofs.
| Could you apply ?

No need to add a trailing space to the function def. line though...
Bad $EDITOR.

--
~Randy
"We have met the enemy and he is us."  -- Pogo (by Walt Kelly)
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
