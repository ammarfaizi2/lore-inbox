Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269601AbTGOTlf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 15:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269602AbTGOTlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 15:41:35 -0400
Received: from main.gmane.org ([80.91.224.249]:59332 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269601AbTGOTle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 15:41:34 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: nick black <dank@suburbanjihad.net>
Subject: Re: Matrox Millenium and framebuffer
Date: Tue, 15 Jul 2003 19:55:25 +0000 (UTC)
Message-ID: <bf1m7d$ol7$1@main.gmane.org>
References: <20030715193545.GA1024@tangerine>
Reply-To: dank@reflexsecurity.com
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030715193545.GA1024@tangerine>, Jean-Luc Coulon (f5ibh) wrote:
> And I pass the parameter video=matrox to the kernel.
> I tried video=matrox:vesa=<something> without any success.

at a minimum, you'll need to provide "matroxfb" rather than "matrox".

-- 
nick black <dank@reflexsecurity.com>
"np:  nondeterministic polynomial-time
the class of dashed hopes and idle dreams." - the complexity zoo

