Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268353AbUIGSRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268353AbUIGSRC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268254AbUIGSOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:14:30 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:43789 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S268334AbUIGSN6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:13:58 -0400
Date: Tue, 7 Sep 2004 22:13:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-mm4
Message-ID: <20040907201359.GA8297@mars.ravnborg.org>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <544180000.1094575502@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <544180000.1094575502@[10.10.2.4]>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 09:45:02AM -0700, Martin J. Bligh wrote:
> Well, the good news is that it compiles now, and without forcing ACPI on.
> Yay!
> 
> On the downside, it seems to have a new error:
> 
> make[1]: warning: jobserver unavailable: using -j1.  Add `+' to parent make rule.

Just an information - I will silent this.
[Hmm, -j 32 on my UP...]

	Sam
