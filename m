Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263013AbVFXCSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263013AbVFXCSK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 22:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbVFXCSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 22:18:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:19156 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263010AbVFXCP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 22:15:26 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: "Clyde Griffin" <CGRIFFIN@novell.com>
cc: linux-kernel@vger.kernel.org, "Jan Beulich" <JBeulich@novell.com>
Subject: Re: Novell Linux Kernel Debugger (NLKD) 
In-reply-to: Your message of "Thu, 23 Jun 2005 16:54:09 CST."
             <s2bae938.075@sinclair.provo.novell.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Jun 2005 12:15:19 +1000
Message-ID: <5949.1119579319@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2005 16:54:09 -0600, 
"Clyde Griffin" <CGRIFFIN@novell.com> wrote:
>
>Novell engineering is introducing the Novell Linux Kernel Debugger
>(NLKD) as an open source project intended to provide an enhanced and
>robust debugging experience for Linux kernel developers.

Hmm, no backtrace, turns off kprobes, does not handle ia64 MCA/INIT.
And don't get me started about the trailing white space in the patch.
I'll stick with KDB for now.

