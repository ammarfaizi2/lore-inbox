Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbTDVW7v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 18:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263896AbTDVW7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 18:59:51 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:47241 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263893AbTDVW7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 18:59:51 -0400
Subject: Re: 2.5 kernel hangs system
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: root@chaos.analogic.com
Cc: Dave Mehler <dmehler26@woh.rr.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0304221649050.17809@chaos>
References: <000501c3090c$71683c60$0200a8c0@satellite>
	 <Pine.LNX.4.53.0304221649050.17809@chaos>
Content-Type: text/plain
Organization: 
Message-Id: <1051053106.710.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 23 Apr 2003 01:11:46 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-22 at 23:00, Richard B. Johnson wrote:
> First, I don't understand how as you say, "suggestions are
> desperately needed" on a developmental kernel. These things are
> not known to work on all configurations and some information like
> "It gives me hex codes..." is worthless. Please write down
> these "hex-codes" and, after booting a version the works, run them
> through ksymoops. If you don't know what that is:

ksymoops? I thought 2.5 kernels didn't need ksymoops anymore and that
function names were automatically "guessed" in call stack traces.

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

