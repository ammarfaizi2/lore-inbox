Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbVFRShA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVFRShA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 14:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVFRSg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 14:36:59 -0400
Received: from mail.dvmed.net ([216.237.124.58]:21651 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262163AbVFRSgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 14:36:45 -0400
Message-ID: <42B469B6.2060502@pobox.com>
Date: Sat, 18 Jun 2005 14:36:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Netdev List <netdev@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x net driver updates
References: <42B456E2.8000500@pobox.com> <Pine.LNX.4.58.0506181047190.2268@ppc970.osdl.org> <Pine.LNX.4.58.0506181105110.2268@ppc970.osdl.org> <Pine.LNX.4.58.0506181112590.2268@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506181112590.2268@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> I'm hoping my earlier pulls on your trees haven't resulted in these kinds 
> of history losses before, and that this was the first time you did a merge 
> and didn't specify the parents properly. Pls confirm..

You're being overly paranoid :)

This netdev-2.6.git episode was the first time I ever tried to use the 
conflict merging.  I didn't know git had improved to the point where 
"git commit" without any arguments would actually get things right.

All the other merges used the vanilla git-pull-script with no 
modifications.  Presumably it does the right thing :)

	Jeff



