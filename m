Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbUENPWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUENPWy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 11:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUENPWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 11:22:54 -0400
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:57756 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S261468AbUENPWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 11:22:51 -0400
Message-ID: <40A4E432.4020202@pobox.com>
Date: Fri, 14 May 2004 11:22:26 -0400
From: Will Dyson <will_dyson@pobox.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] befs (1/5): LBD support
References: <200405132232.09816.rathamahata@php4.ru>
In-Reply-To: <200405132232.09816.rathamahata@php4.ru>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey S. Kostyliov wrote:
> LBD patch merged long time ago, so it is safe to pass u64 block
> numbers to sb_bread() when sector_t is large enough.

Nice. I haven't mounted any of my BeFS volumes in quite some months now. 
  Are you interested in taking over official maintainership?

-- 
Will Dyson
"Back off man, I'm a scientist!" -Dr. Peter Venkman
