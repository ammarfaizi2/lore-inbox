Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268191AbUIPPfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268191AbUIPPfR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 11:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268293AbUIPPWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 11:22:17 -0400
Received: from host62-24-231-115.dsl.vispa.com ([62.24.231.115]:4480 "EHLO
	orac.walrond.org") by vger.kernel.org with ESMTP id S268191AbUIPPTf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 11:19:35 -0400
From: Andrew Walrond <andrew@walrond.org>
To: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
Subject: Re: lost memory on a 4GB amd64
Date: Thu, 16 Sep 2004 16:19:28 +0100
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au> <200409161528.19409.andrew@walrond.org> <Pine.LNX.4.58.0409170051200.26494@fb07-calculator.math.uni-giessen.de>
In-Reply-To: <Pine.LNX.4.58.0409170051200.26494@fb07-calculator.math.uni-giessen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409161619.28742.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 Sep 2004 15:56, Sergei Haller wrote:
> On Thu, 16 Sep 2004, Andrew Walrond (AW) wrote:
>
> AW>
> AW> On further investigation, The settings I mentioned, 'Auto' and
> 'Continuous' AW> only work when running a 64bit kernel. Are you running a
> 32bit kernel?
>
> it's a 64bit one. the precise setting for the processor is
> "AMD-Opteron/Athlon64". Should I try "Generic-x86-64"?

No - thats what I use. Do you have MTRR support enabled?

I'll send you my .config file; Perhaps you could try that.

Andrew
