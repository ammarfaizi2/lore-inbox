Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWAaNPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWAaNPY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 08:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWAaNPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 08:15:24 -0500
Received: from iona.labri.fr ([147.210.8.143]:27060 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S1750802AbWAaNPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 08:15:23 -0500
Message-ID: <43DF629E.7070300@labri.fr>
Date: Tue, 31 Jan 2006 14:14:06 +0100
From: Emmanuel Fleury <emmanuel.fleury@labri.fr>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ASLR] Better control on Randomization
References: <43DE710F.9020408@labri.fr>
In-Reply-To: <43DE710F.9020408@labri.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some more details...

Emmanuel Fleury wrote:
> 
> Would it be possible to tweak them independently from each other ?
> (still via procfs)

I mean it surely immply some modifications of the kernel source. My
question is more about where to locate the "if" to stop only one or the
other.

Regards
-- 
Emmanuel Fleury

A journey of a thousand miles must begin with a single step.
   -- Lao Tzu
