Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVDKQXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVDKQXu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVDKQW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:22:26 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52729 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261836AbVDKQUB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:20:01 -0400
Subject: Re: [PATCH] Priority Lists for the RT mutex
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, sdietrich@mvista.com,
       inaky.perez-gonzalez@intel.com
In-Reply-To: <20050410105319.GA7303@elte.hu>
References: <1112896344.16901.26.camel@dhcp153.mvista.com>
	 <20050410105319.GA7303@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1113236393.30549.4.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Apr 2005 09:19:54 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-10 at 03:53, Ingo Molnar wrote:

> ok, i've added this patch to the -45-00 release. It's looking good on my 
> testsystems so far, but it will need some more testing i guess.


Yes, I ran the PI test, and just let the system run .. So it could use
more extensive testing..

Daniel 

