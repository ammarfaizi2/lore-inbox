Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVDEHZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVDEHZZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 03:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVDEHXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:23:08 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:22588 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261589AbVDEHVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:21:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=MOUhbMhv4iBN5oGtvneqopPuQbRcFndlYcsq+ESmxFL6a57iIG6z/PhdkLAe1Cgbm2nbb2M4IQ+NLtDYWy41w4o742YFTGEz8adCU6Ok1eMLW9vPXfJWi17o4Z8Z5CaSsCpAM3RvrCD3CZbkPRu40JhImV1pPBuYyfK4tjOnvIA=
Message-ID: <21d7e9970504050021419911b0@mail.gmail.com>
Date: Tue, 5 Apr 2005 17:21:20 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc2-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050405000524.592fc125.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050405000524.592fc125.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> - Nobody said anything about the PM resume and DRI behaviour in
>   2.6.12-rc1-mm4.  So it's all perfect now?

Well the DRI is, both reports of bugs have been fixed :-), the bug
should be closed on bugs.kernel.org I think, and it looks rock solid
on my box both FC3 and Debian sarge..

Dave.
