Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262639AbVA0PkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbVA0PkZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 10:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVA0PkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 10:40:25 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:11761 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262639AbVA0PkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 10:40:23 -0500
Date: Thu, 27 Jan 2005 07:40:17 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Steve Lord <lord@xfs.org>
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Preempt & Xfs Question
Message-ID: <20050127154017.GA12493@taniwha.stupidest.org>
References: <41F91470.6040204@tiscali.de> <41F908C4.4080608@xfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F908C4.4080608@xfs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BUG: using smp_processor_id() in preemptible [00000001] code:
> khelper/892

fixed in CVS, I guess it will hit mainline soon
