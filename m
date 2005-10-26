Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbVJZJit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVJZJit (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 05:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVJZJit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 05:38:49 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:7069 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751286AbVJZJit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 05:38:49 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Vladimir Lazarenko <vlad@lazarenko.net>
Subject: Re: sata_nv + SMP = broken?
Date: Wed, 26 Oct 2005 11:39:09 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Marc Perkel <marc@perkel.com>,
       Jeff Garzik <jgarzik@pobox.com>
References: <4358C417.9000608@lazarenko.net> <435A9A1B.4040907@lazarenko.net> <435ED5E3.3060405@lazarenko.net>
In-Reply-To: <435ED5E3.3060405@lazarenko.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510261139.10169.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 26 of October 2005 03:03, Vladimir Lazarenko wrote:
}-- snip --{
> 
> Let me know if i need to test anything or you want more info.

Could you please create a Bugzilla entry for that, and put all of the
information you think can be relevant in there (including
.config(s), the output(s) of dmesg, the contents of /proc/interrupts
etc. for failing configurations)?

Greetings,
Rafael
