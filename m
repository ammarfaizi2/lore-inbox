Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161017AbWGNKNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbWGNKNk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 06:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161019AbWGNKNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 06:13:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:52867 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161017AbWGNKNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 06:13:39 -0400
Subject: Re: 2.6.18-rc1-git4 and 2.6.18-rc1-mm1 OOM's on boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@osdl.org>, mbligh@google.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <44B756AB.50102@shadowen.org>
References: <44B528F4.6080409@google.com>
	 <20060712181636.d7cbbb99.akpm@osdl.org>	<44B5A0DD.9070200@google.com>
	 <44B654EA.3030301@shadowen.org>	<44B74F24.2060209@shadowen.org>
	 <20060714010858.d6824f1f.akpm@osdl.org>  <44B756AB.50102@shadowen.org>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 20:13:20 +1000
Message-Id: <1152872000.23037.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I can only see two outstanding issues.  An IDE lost interrupt issue on a 
> blade we have under test which I believe benh is looking at, and what 
> looks like an s390 tool chain issue which I am told is being looked at.

Yeah, well, I'm trying to look at it... between flights :)

Ben.


