Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbUJ1SxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbUJ1SxK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 14:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbUJ1Sw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 14:52:59 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:51643 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261970AbUJ1SvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 14:51:07 -0400
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: akpm@osdl.org, cw@f00f.org
Subject: Re: [patch 2/7] uml: Build fix for TT w/o SKAS
Date: Thu, 28 Oct 2004 20:49:42 +0200
User-Agent: KMail/1.7.1
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
References: <200410272223.i9RMNg921807@mail.osdl.org>
In-Reply-To: <200410272223.i9RMNg921807@mail.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410282049.42376.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 00:27, akpm@osdl.org wrote:
> From: Chris Wedgwood <cw@f00f.org>

> This is required to get UML to build with only TT mode.

Drop that - the fix is in my tree currently, I'll forward it soon. And the 
fix, instead of #ifdef'ing it out, adds the support for using TT & SYSEMU.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
