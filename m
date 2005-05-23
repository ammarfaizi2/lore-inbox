Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVEWXRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVEWXRJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVEWXQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:16:54 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:32508 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261215AbVEWXO2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:14:28 -0400
Subject: RT patch acceptance
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, akpm@osdl.org, sdietrich@mvista.com
Content-Type: text/plain
Organization: MontaVista
Date: Mon, 23 May 2005 16:14:26 -0700
Message-Id: <1116890066.13086.61.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello World!

I went to see Andrew Morton speak at Xerox PARC and he indicated that
some of the RT patch was a little crazy . Specifically interrupts in
threads (Correct me if I'm wrong Andrew). It seems a lot of the
maintainers haven't really warmed up to it. 

I don't know to what extent Ingo has lobbied to try to get acceptance
into an unstable or stable kernel. However, since I know Andrew is cold
to accepting it , I thought I would ask what would need to be done to
the RT patch so that it could be accepted?

I think the fact that some distributions are including RT patched
kernels is a sign that this technology is getting mature. Not to mention
the fact that it's a 600k+ patch and getting bigger everyday. 

I'm sure there are some people fiercely opposed to it, some of whom I've
already run into. What is it about RT that gets people's skin crawling?
It is a configure option after all.

Daniel

