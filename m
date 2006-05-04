Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWEDJin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWEDJin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 05:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWEDJim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 05:38:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19215 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751462AbWEDJiY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 05:38:24 -0400
Date: Thu, 4 May 2006 07:17:37 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Remove silly messages from input layer.
Message-ID: <20060504071736.GB5359@ucw.cz>
References: <20060504024404.GA17818@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504024404.GA17818@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-05-06 22:44:04, Dave Jones wrote:
> There are two messages in the input layer that seem to be
> triggerable very easily, and they confuse end-users to no end.
> "too many keys pressed? Should I press less keys?"

It actually means 'type more slowly' or 'use standard keymap' or 'get
a better keyboard' :-) or 'no, you are not imagining it, I've seen
your keypress and dropped it'.
									Pavel

-- 
Thanks, Sharp!
