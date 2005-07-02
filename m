Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVGBRdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVGBRdm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 13:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVGBRdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 13:33:42 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:49318 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261227AbVGBRdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 13:33:39 -0400
Subject: Re: aic7xxx regression occuring after 2.6.12 final
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tony Vroon <chainsaw@gentoo.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <1120324426.21967.1.camel@localhost>
References: <1120085446.9743.11.camel@localhost>
	 <1120318925.21935.9.camel@localhost>  <1120321322.5073.4.camel@mulgrave>
	 <1120322788.22046.2.camel@localhost>  <1120323691.5073.12.camel@mulgrave>
	 <1120324426.21967.1.camel@localhost>
Content-Type: text/plain
Date: Sat, 02 Jul 2005 13:33:33 -0400
Message-Id: <1120325613.5073.16.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-02 at 18:13 +0100, Tony Vroon wrote:
> wscsi0: target 0 using asynchronous transfers
> [vendor information follows; Fujitsu MAP 36.7GB drive]

There should be more debugging information after this as the device goes
through domain validation, isn't there?

James 

