Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUELVKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUELVKA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbUELVJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:09:23 -0400
Received: from bab72-140.optonline.net ([167.206.72.140]:15745 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP id S263775AbUELVI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:08:29 -0400
To: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Assembler warnings on Alpha
References: <yw1x1xlpv0pj.fsf@kth.se>
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
Date: 12 May 2004 17:03:38 -0400
In-Reply-To: <yw1x1xlpv0pj.fsf@kth.se>
Message-ID: <xlthdulpdcl.fsf@shookay.newview.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@kth.se (Måns Rullgård) writes:
> When building Linux 2.6.6 on Alpha, I get numerous of these warnings:
> 
> {standard input}:6: Warning: setting incorrect section attributes for .got
> 
> What's going on?  I'm using gcc 3.3.3 and binutils 2.15.90.  Are these
> not good?  Is the resulting kernel safe to boot?

Mine boots and the box has been up for few days now...
-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
