Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbUL2TiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbUL2TiF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 14:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbUL2TiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 14:38:05 -0500
Received: from mail.scs.ch ([212.254.229.5]:25751 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id S261404AbUL2Tho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 14:37:44 -0500
Subject: Re: ptrace single-stepping change breaks Wine
From: Thomas Sailer <sailer@scs.ch>
To: Mike Hearn <mh@codeweavers.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Jesse Allen <the3dfxdude@gmail.com>, Daniel Jacobowitz <dan@debian.org>,
       Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
In-Reply-To: <1104332559.3393.16.camel@littlegreen>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <419E42B3.8070901@wanadoo.fr>
	 <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
	 <419E4A76.8020909@wanadoo.fr>
	 <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
	 <419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org>
	 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>
	 <20041120214915.GA6100@tesore.ph.cox.net> <41A251A6.2030205@wanadoo.fr>
	 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>
	 <1101161953.13273.7.camel@littlegreen>
	 <1104286459.7640.54.camel@gamecube.scs.ch>
	 <1104332559.3393.16.camel@littlegreen>
Content-Type: text/plain
Organization: SCS
Date: Wed, 29 Dec 2004 20:35:44 +0100
Message-Id: <1104348944.5645.2.camel@kronenbourg.scs.ch>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-29 at 15:02 +0000, Mike Hearn wrote:

Mike,

thanks a lot for your mail. I've just tried Jesse Allen's Patch with
2.6.10-ac1, but unfortunately it doesn't seem to be enough to get xst
working again. Let me know if (and how :)) I can help gather evidence.

Tom


