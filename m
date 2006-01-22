Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWAVWsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWAVWsr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 17:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWAVWsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 17:48:47 -0500
Received: from xenotime.net ([66.160.160.81]:4267 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932312AbWAVWsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 17:48:47 -0500
Date: Sun, 22 Jan 2006 14:48:52 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Brown, Len" <len.brown@intel.com>
Cc: jamagallon@able.es, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: SMP+nosmp=hang [was: Re: 2.6.15-rc5-mm2]
Message-Id: <20060122144852.7165bb81.rdunlap@xenotime.net>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005CA25F3@hdsmsx401.amr.corp.intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005CA25F3@hdsmsx401.amr.corp.intel.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jan 2006 16:47:24 -0500 Brown, Len wrote:

> I think nosmp has been broken for a long time:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=1641
> 
> try maxcpus=1 instead of nosmp.

Yes, I know that it's not recent.

Thanks for the bugz #.  I had already searched for that
but didn't find it.

---
~Randy
