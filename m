Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWHRWmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWHRWmZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWHRWmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:42:25 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:17926 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S964851AbWHRWmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:42:23 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <alan@lxorguk.ukuu.org.uk>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: GPL Violation?
Date: Fri, 18 Aug 2006 15:42:10 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEBCNOAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
In-Reply-To: <1155919950.30279.8.camel@localhost.localdomain>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 18 Aug 2006 15:36:59 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 18 Aug 2006 15:37:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ar Gwe, 2006-08-18 am 02:51 -0700, ysgrifennodd David Schwartz:

	Re the DMCA issues with printers, courts seem to be holding that the rights
management system has to enforce an actual right. Since a printer
manufacturer has no right to limit you to cartridges he makes, the DMCA does
not apply. (This would be very good if more courts would hold it more
consistenly on other issues as well. Sadly, that may not be happening.)

> EXPORT_SYMBOL_GPL is clearly a rights management systems. Thats one of
> its little charms.

	No, it is not. If it was, it would violate the GPL. The GPL prohibits any
restrictions not contained in the GPL, and the GPL doesn't say anything
about EXPORT_SYMBOL_GPL. To the contrary, the GPL prohibits restrictions on
use. So EXPORT_SYMBOL_GPL violates the GPL if you are not free to circumvent
or remove it.

	We had this same discussion a few years ago, and my recollection was that
you agreed that EXPORT_SYMBOL_GPL could not be a license enforcement scheme.
Which term of the GPL do you think it enforces exactly?

	Whose rights does it enforce? (Considering that nobody has the right to
prevent me from using the Linux kernel with an undistributed derivative work
that is not covered by the GPL.)

	DS


