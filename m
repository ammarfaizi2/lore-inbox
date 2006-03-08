Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWCHVy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWCHVy7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWCHVy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:54:59 -0500
Received: from host1.compusonic.fi ([195.238.198.242]:17945 "EHLO
	minor.compusonic.fi") by vger.kernel.org with ESMTP
	id S1751127AbWCHVy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:54:58 -0500
Date: Wed, 8 Mar 2006 23:54:01 +0200 (EET)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: Dave Neuer <mr.fred.smoothie@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [future of drivers?] a proposal for binary drivers.
In-Reply-To: <161717d50603080659t53462cd0k53969c0d33e06321@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0603082336410.11026@zeus.compusonic.fi>
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com> 
 <20060308102731.GO27946@ftp.linux.org.uk>  <ec92bc30603080252v7e795b4dm5116d4fe78f92cc7@mail.gmail.com>
 <161717d50603080659t53462cd0k53969c0d33e06321@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2006, Dave Neuer wrote:

> What is linux-specific in this context is that many people, like
> myself, who have contributed code to the kernel under the GPL *don't
> want* their code to be used in non-free software, period. Someone who
> wants to leverage my work needs to do it under the terms that I allow.
> That is the law. Whining is not going to change my mind.
> 
> If a company thinks they can make money selling hardware with
> closed-source drivers (on some other OS), more power to them. If a
> company thinks they can make money selling hardware with open-source
> drivers on Linux and want to leverage my work, more power to them
> (I'll even help them). But they can't use my work and not release the
> code.
You are mixing two different things. Binary driver is not the same thing 
as binary-only driver. Being binary means just that the driver is 
distributed as a precompiled module. However the driver may still be open 
sourced (under GPL or whatever license you like). The full source 
code may be shipped with the installable binary or be distributed in some 
other way for users who want to compile it themselves. 

In fact all Linux distributions ship binary drivers. The user can install 
the kernel/driver sources but most "ordinary" users don't install them. 

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
