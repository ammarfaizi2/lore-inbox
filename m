Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264762AbTFAXW6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 19:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264763AbTFAXW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 19:22:58 -0400
Received: from imsantv30.netvigator.com ([210.87.253.77]:51410 "EHLO
	imsantv30.netvigator.com") by vger.kernel.org with ESMTP
	id S264762AbTFAXW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 19:22:57 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: "Lauro, John" <jlauro@umflint.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20, 2.4.21-rc6 both stalls - from low free memory
Date: Mon, 2 Jun 2003 07:35:50 +0800
User-Agent: KMail/1.5.2
References: <37885B2630DF0C4CA95EFB47B30985FB0187FFE1@exchange-1.umflint.edu>
In-Reply-To: <37885B2630DF0C4CA95EFB47B30985FB0187FFE1@exchange-1.umflint.edu>
X-OS: GNU/Linux 2.5.70
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306020735.50368.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I need to get this system stable under heavy writes.  What kernel do
> you
> recommend?  The lowest (I think) I can go back to is 2.4.16 for driver
> reasons. Support for >12GB is critical.  What kernel versions started
> having
> this problem?

IIRC the list says it started in 2.4.19-preX.

If 2.4.21-rc6 causes problems try 2.4.18 plain first, 
only if required add matching ACPI patch from SF.

Regards
Michael

