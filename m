Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWCTSb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWCTSb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 13:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWCTSb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 13:31:59 -0500
Received: from mra01.ch.as12513.net ([82.153.252.23]:25794 "EHLO
	mra01.ch.as12513.net") by vger.kernel.org with ESMTP
	id S1751234AbWCTSb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 13:31:58 -0500
Subject: Re: Announcing crypto suspend
From: Peter Wainwright <prw@ceiriog.eclipse.co.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060320080439.GA4653@elf.ucw.cz>
References: <20060320080439.GA4653@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 18:35:05 +0000
Message-Id: <1142879707.9475.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-20 at 09:04 +0100, Pavel Machek wrote:
> Hi!
> 
> Thanks to Rafael's great work, we now have working encrypted suspend
> and resume. You'll need recent -mm kernel, and code from
> suspend.sf.net. Due to its use of RSA, you'll only need to enter
> password during resume.
> 
> [Code got some minimal review; if you are a crypto expert, and think
> you can poke a hole within it, please try to do so.]
> 								Pavel
Thats pretty interesting - we really need a featureful suspend
implementation
in mainline. But there doesn't seem to be much documentation for it.
suspend.sf.net takes me to the Suspend 2 site: www.suspend2.net (a
virtual
server?). Which code from this site is needed for the mainline suspend?

Peter


