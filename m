Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbUCDKcQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 05:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbUCDKcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 05:32:16 -0500
Received: from main.gmane.org ([80.91.224.249]:7307 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261825AbUCDKcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 05:32:06 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PATCH] UTF-8ifying the kernel source
Date: Thu, 04 Mar 2004 11:32:03 +0100
Message-ID: <yw1xsmgogaxo.fsf@kth.se>
References: <20040304100503.GA13970@havoc.gtf.org> <E1Aypx5-0000mb-5u@rhn.tartu-labor>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:fdWBTi0oj/1jYY3dQKtteiWdt+E=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos <mroos@linux.ee> writes:

> DE> Here you find the first of several patches to convert the kernel
> DE> source from ISO Latin-1 to UTF-8.  I'm working on the files that didn't
> DE> auto-convert easily; comments welcome ;-)
>
> Why? It's just easier to use plain 8-bit text files today (with editors,
> code tools etc) and accept the limitations of it that to overcome the
> limitations by forcing people to UTF-8 editors & other tools.

How do you propose that editors should know which encoding a file
uses?  The trend seems to be moving towards UTF-8 for everything, so
the kernel might as well do it too.

-- 
Måns Rullgård
mru@kth.se

