Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751702AbWEPIwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbWEPIwS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 04:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbWEPIwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 04:52:17 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.25]:31370 "EHLO smtp6.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1751695AbWEPIwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 04:52:17 -0400
X-ME-UUID: 20060516085216423.0A1101C000A6@mwinf0602.wanadoo.fr
Subject: RE: GPL and NON GPL version modules
From: Xavier Bestel <xavier.bestel@free.fr>
To: davids@webmaster.com
Cc: Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKCEPGLOAB.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKCEPGLOAB.davids@webmaster.com>
Content-Type: text/plain
Message-Id: <1147769525.25330.137.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Tue, 16 May 2006 10:52:05 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-16 at 05:42, David Schwartz wrote:
> > 1. I developed a code which interfaces well with a proprietary OS. Now,
> > somebody else feels to use the same module in his Linux Kernel. So, he
> > comes up with a patch, which interfaces and talks to my module with my
> > interfaces and then makes a release with the patch. And, I would have no
> > idea of my module being really compatible/used in Linux Kernel. One fine
> > day, I would get a mail saying that I need to make my code open source.
> > What would be my reply?
> 
> 	When you say "makes a release with the patch", what are you talking about?
> A release of what? It sounds like all you need to do is include a note in
> your license that you prohibit combining your code with GPL'd code and
> distributing the result. Talk to a lawyer about the right wording, but you
> want to impose complying with any GPL obligations on the person who chooses
> to combine your code with GPL'd code. Then it's not your problem.
> 
> 	However, I don't see how it's your problem anyway. This sounds way outside
> the scope of the GPL or any copyright license. Since your module is not a
> derivative work of any GPL'd work, it should be well outside the scope of
> the GPL.

Unless the "someone else will release a GPL wrapper to my proprietary
module" accident is planned from the start.

	Xav


