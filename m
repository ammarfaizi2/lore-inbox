Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVCCCAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVCCCAa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 21:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVCCB6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 20:58:52 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:21652 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261336AbVCCBzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 20:55:14 -0500
From: Russell Miller <rmiller@duskglow.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: RFD: Kernel release numbering
Date: Wed, 2 Mar 2005 17:56:14 -0800
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Matt Mackall <mpm@selenic.com>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302162312.06e22e70.akpm@osdl.org> <422666F9.4040807@yahoo.com.au>
In-Reply-To: <422666F9.4040807@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503021756.15017.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 March 2005 17:23, Nick Piggin wrote:

> Then your above becomes:
> 2.6.x-rc: bugfixes only
> 2.6.x-pre: bugfixes and features
>
> And then that doesn't confuse end users either.
>
Speaking as an "ordinary" end user (there's nothing ordinary about me) I think 
the idea of even/odd releases is silly.  This accomplishes the same goals, 
and is less confusing all told.

Linus's plan will work well for about...  two releases, then people will wise 
up and stop testing the odd releases.  I know that's what I'll probably end 
up doing.

--Russell

-- 

Russell Miller - rmiller@duskglow.com - Agoura, CA
