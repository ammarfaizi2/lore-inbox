Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263214AbVFXHnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263214AbVFXHnl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 03:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbVFXHjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 03:39:21 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:1338
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S263205AbVFXHiU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 03:38:20 -0400
Message-Id: <42BBD4A1020000780001D4D1@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 24 Jun 2005 09:38:41 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "jmerkey" <jmerkey@utah-nac.org>
Cc: "Christoph Lameter" <christoph@lameter.com>,
       "Clyde Griffin" <CGRIFFIN@novell.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Novell Linux Kernel Debugger (NLKD)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>1. No back trace

You're the second one to mention this, and I wonder where you take this from.

>2. Doesn't run standalone fully embeded in the kernel

What do you mean with 'fully embedded'? As long as the agents aren't compiled as modules, everything's right in the kernel (of course, not the mainline one, but that's same as for kdb and kgdb).

>3. Not fully open source (since it's not embeded in the kernel)

What has embedding things in the kernel to do with being open source?

>5. No advanced recursive descent parser for conditional breakpoints

Where've you seen this? What functionality does the parser miss?

Jan

