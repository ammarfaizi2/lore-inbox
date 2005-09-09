Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbVIIVcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbVIIVcP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 17:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbVIIVcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 17:32:15 -0400
Received: from S0106000ea6c7835e.no.shawcable.net ([70.67.106.153]:29650 "EHLO
	prophet.net-ronin.org") by vger.kernel.org with ESMTP
	id S1030357AbVIIVcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 17:32:15 -0400
Date: Fri, 9 Sep 2005 14:29:03 -0700
From: carbonated beverage <ramune@net-ronin.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: errs from build/makefiles
Message-ID: <20050909212903.GA10117@prophet.net-ronin.org>
References: <20050909192113.GA8621@prophet.net-ronin.org> <20050909205946.GB19008@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909205946.GB19008@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 10:59:46PM +0200, Sam Ravnborg wrote:
> Using the ':' buildin in several places is such a speedup for normal
> usage that I do not plan to replace it with anything else.

So what about adding SHELL=bash at the top-level makefile?

-- DN
Daniel
