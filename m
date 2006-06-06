Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWFFNpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWFFNpG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 09:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWFFNpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 09:45:06 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:4588 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932166AbWFFNpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 09:45:05 -0400
Subject: Re: 2.6.18 -mm pi-futex merge
From: Steven Rostedt <rostedt@goodmis.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de
In-Reply-To: <Pine.LNX.4.64.0606061530330.17704@scrub.home>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <1149597128.16247.40.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606061530330.17704@scrub.home>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 09:44:56 -0400
Message-Id: <1149601496.16247.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 15:34 +0200, Roman Zippel wrote:

> BTW what's the correct spelling - RT Mutex, rt mutex or rt-mutex?

I'd recommend "RT Mutex" for when it is in titles (as it is now) and
rt-mutex when explaining the code.  IMO "rt mutex" is just wrong.

-- Steve


