Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbTDIFRe (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 01:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbTDIFRe (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 01:17:34 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:10685 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262728AbTDIFRd (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 01:17:33 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: fdavis@si.rr.com, linux-kernel@vger.kernel.org
Subject: Re: kernel support for non-english user messages
Date: Wed, 9 Apr 2003 07:29:08 +0200
User-Agent: KMail/1.5
References: <3E93A958.80107@si.rr.com>
In-Reply-To: <3E93A958.80107@si.rr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304090729.08738.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm looking for a possible uniform design to make this happen, short of
> adding a complete machine translation module to the kernel. :) Userland
> internationalization support is already provided(I haven't personally
> used other languages besides English, but I've seen the options), but a
> kernel module or printk addition that handles localized kernel messages
> seems reasonable.
>
> Thoughts, comments?

These messages are for administrators and developers. Everybody needs
to be able to read them. They have to be in English.

	Regards
		Oliver

