Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264664AbUEVBBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264664AbUEVBBF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 21:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbUEVA7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 20:59:25 -0400
Received: from ms-smtp-02-smtplb.ohiordc.rr.com ([65.24.5.136]:2189 "EHLO
	ms-smtp-02-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S265120AbUEVA4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 20:56:32 -0400
From: Rob Couto <rpc@cafe4111.org>
Reply-To: rpc@cafe4111.org
Organization: Cafe 41:11
To: "Timothy Miller" <theosib@hotmail.com>
Subject: Re: [OT] Linux stability despite unstable hardware
Date: Fri, 21 May 2004 20:55:14 -0400
User-Agent: KMail/1.6.1
References: <BAY1-F135u0T4Dk5Je6000264da@hotmail.com>
In-Reply-To: <BAY1-F135u0T4Dk5Je6000264da@hotmail.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405212055.14789.rpc@cafe4111.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 May 2004 05:57 pm, you wrote:

> So, what is it about Linux that makes it build properly with a broken GCC
> and run perfectly despite memory errors?

probably just the sources... i built a bunch of gentoo on a flaky machine, and 
ran into trouble with mozilla. it was mozilla 1.6 that demostrated the 
problems and prevented me from continuing to build gnome. i ended up 
rebuilding the whole thing on a speedy box over a weekend, for a far weaker 
architecture that wasn't flaky (despite 4 or 5 brutal soldering adventures on 
the motherboard!!!)

-- 
Rob Couto [rpc@cafe4111.org]
computer safety tip: use only a non-conducting, static-free hammer.
--
