Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbWILTIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWILTIH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 15:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWILTIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 15:08:07 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:50618 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030363AbWILTIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 15:08:04 -0400
Message-ID: <45070577.9040100@oracle.com>
Date: Tue, 12 Sep 2006 12:07:35 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Frederik Deweerdt <deweerdt@free.fr>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rmk+kernel@arm.linux.org.uk
Subject: Re: [-mm patch] arm build fail: vfpsingle.c
References: <20060912000618.a2e2afc0.akpm@osdl.org> <20060912200522.GN3775@slug> <4506FC2D.2070109@oracle.com> <20060912210039.GB1539@slug>
In-Reply-To: <20060912210039.GB1539@slug>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes it does, but the intended use of 'func' (or so I understood) is to
> print the calling function name, not the current function's, isn't it?

Dunno, I took it to mean the current function from the context of that
patch.  I could be wrong, of course.

- z
