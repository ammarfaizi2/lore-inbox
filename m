Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVCBXeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVCBXeL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVCBX1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:27:12 -0500
Received: from mail.portrix.net ([212.202.157.208]:44509 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261356AbVCBXYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:24:16 -0500
Message-ID: <42264B12.6060601@ppp0.net>
Date: Thu, 03 Mar 2005 00:24:02 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050116 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11
References: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok,
>  there it is. Only small stuff lately  - as promised. Shortlog from -rc5 
> appended, nothing exciting there, mostly some fixes from various code 
> checkers (like fixed init sections, and some coverity tool finds).
> 
> So it's now _officially_ all bug-free.

At least it builds 14 out of 23 arch defconfigs (http://l4x.org/k/),
which is quite an improvement over 10/22 of 2.6.10.

Congrats,

Jan
