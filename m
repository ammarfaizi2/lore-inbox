Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbTLSSt0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 13:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTLSSt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 13:49:26 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:61871 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263007AbTLSStZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 13:49:25 -0500
Date: Fri, 19 Dec 2003 18:48:56 +0000
From: Dave Jones <davej@redhat.com>
To: Lars Damerow <lars@pixar.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: help debugging kernel freeze w/sysrq-t traces?
Message-ID: <20031219184856.GB24413@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Lars Damerow <lars@pixar.com>, linux-kernel@vger.kernel.org
References: <20031219183027.GA2198@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031219183027.GA2198@pixar.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 19, 2003 at 10:30:29AM -0800, Lars Damerow wrote:
 > - kernel version: 2.4.22-1.2115.nptlsmp (stock Fedora Core 1 kernel)

First try the latest errata kernel, then if its repeatable
file a bug in http://bugzilla.redhat.com

		Dave

