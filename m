Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVGLRyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVGLRyU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 13:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVGLRyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 13:54:14 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:12707 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261790AbVGLRwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 13:52:49 -0400
Subject: Re: [BUG] Fusion MPT Base Driver initialization failure with kdump
From: James Bottomley <James.Bottomley@SteelEye.com>
To: bharata@in.ibm.com
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1121147809.10622.9.camel@localhost.localdomain>
References: <1121147809.10622.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 12:23:27 -0400
Message-Id: <1121185408.4825.22.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 11:26 +0530, Bharata B Rao wrote:
> Fusion MPT base driver fails during initialization when kdump capture
> kernel boots. The details of the problem are reported here:

This bug report is pretty useless to me because I do a lot of my email
when I'm offline, so I can't get to the bugzilla report and you supply
no other details.

Also, we've invested quite a bit of effort persuading IBM to alter the
kernel bugzilla to collect email replies into the bug report, so if you
wish to bother the email list it should be

1. With the full bug report that allows people actually to assess the
problem
2. cc'd to the correct bugzilla address so that bugzilla itself collects
any replies and suggestions.

James


