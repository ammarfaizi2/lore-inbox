Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267346AbUG1Rar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267346AbUG1Rar (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 13:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267343AbUG1Rar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 13:30:47 -0400
Received: from mail3.speakeasy.net ([216.254.0.203]:47503 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S267348AbUG1Rak
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 13:30:40 -0400
Date: Wed, 28 Jul 2004 10:30:36 -0700
Message-Id: <200407281730.i6SHUaUV016494@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: davidm@hpl.hp.com
X-Fcc: ~/Mail/linus
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: comment "ptrace_list" and "children" members
In-Reply-To: David Mosberger's message of  Wednesday, 28 July 2004 10:26:33 -0700 <16647.57801.568015.688380@napali.hpl.hp.com>
X-Windows: graphics hacking :: Roman numerals : sqrt (pi)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A while ago I had a "fun" time sorting out how the "ptrace_children"
> and the "children" lists are being used.  I think the two little
> comments would help making that process a lot easier (they're based on
> an earlier email by Roland).

Last time I debugged a ptrace-related bug, I too spent a good little while
going in circles because I couldn't keep track from day to day how those
lists were being used.  Those comments would help at least some.


Thanks,
Roland
