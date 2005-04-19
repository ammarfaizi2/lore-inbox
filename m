Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVDSU0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVDSU0k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 16:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVDSU0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 16:26:40 -0400
Received: from mail.enyo.de ([212.9.189.167]:6848 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261367AbVDSU0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 16:26:39 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Chuck Wolber <chuckw@quantumlinux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Development Model
References: <Pine.LNX.4.60.0504182219360.6679@bailey.quantumlinux.com>
Date: Tue, 19 Apr 2005 22:26:35 +0200
In-Reply-To: <Pine.LNX.4.60.0504182219360.6679@bailey.quantumlinux.com> (Chuck
	Wolber's message of "Mon, 18 Apr 2005 22:31:43 -0700 (PDT)")
Message-ID: <87r7h6h5s4.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chuck Wolber:

> Has the Linux Kernel reached a point where the majority of developers feel 
> that (at least for now) no *MAJOR* "rip it out, stomp on it, burn it and 
> start over" parts of the kernel exist any longer?

The IP stack is likely to see some development activity, at leat there
are some specs floating around which contain requirements which the
current IP routing implementation cannot match (deterministic
forwarding and things like that).

I don't know if the results will be published and integrated in the
main kernel tree, though.
