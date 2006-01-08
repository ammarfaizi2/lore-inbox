Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161182AbWAHK7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161182AbWAHK7K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 05:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161184AbWAHK7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 05:59:10 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:59537 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1161182AbWAHK7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 05:59:09 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm 1/2] swsusp: low level interface
Date: Sun, 8 Jan 2006 12:00:35 +0100
User-Agent: KMail/1.9
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
References: <200601071328.39707.rjw@sisk.pl> <200601072156.25876.rjw@sisk.pl> <20060107152700.692c52e7.akpm@osdl.org>
In-Reply-To: <20060107152700.692c52e7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601081200.36308.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 8 January 2006 00:27, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > Could you please see if this looks better than the previous one?
> >
> 
> I think so.  I guess we should wrap the swapfile.c functions in
> CONFIG_SOFTWARE_SUSPEND though.

I'll do that and I'll resend the patches in a new thread.
