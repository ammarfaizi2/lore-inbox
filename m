Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267951AbUIUV03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267951AbUIUV03 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 17:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268072AbUIUV03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 17:26:29 -0400
Received: from hera.cwi.nl ([192.16.191.8]:33461 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S267951AbUIUV02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 17:26:28 -0400
Date: Tue, 21 Sep 2004 23:26:20 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
Message-ID: <20040921212620.GA15559@apps.cwi.nl>
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <41505AA1.A51DEE50@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41505AA1.A51DEE50@users.sourceforge.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2004 at 07:45:21PM +0300, Jari Ruusu wrote:

> How about implementing /etc/fstab option parsing code that is compatible
> with existing libc /etc/fstab parsing code:
> 
> defaults,noauto,comment=kudzu,rw
>                 ^^^^^^^^^^^^^

Is there such libc parsing code? Can you tell me which libc?
Which file? Invoked for what function calls?

Andries
