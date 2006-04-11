Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWDKMTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWDKMTc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 08:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWDKMTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 08:19:31 -0400
Received: from mail.bmlv.gv.at ([193.171.152.37]:28111 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id S1750795AbWDKMTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 08:19:31 -0400
From: "Ph. Marek" <philipp.marek@bmlv.gv.at>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem substituting /proc/mounts for recovery
Date: Tue, 11 Apr 2006 14:17:52 +0200
User-Agent: KMail/1.9.1
References: <200604071224.31851.philipp.marek@bmlv.gv.at>
In-Reply-To: <200604071224.31851.philipp.marek@bmlv.gv.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604111417.52737.philipp.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 April 2006 12:24, Ph. Marek wrote:
> During recovery I'm running off a chroot (booted via knoppix);
> I'm trying to fake a mount table, so that the output of mount
> and df can be correctly parsed by the boot loader installation
> (in the chroot the "df -k /boot" returns no device).
....

Did I do something wrong, or is this just a warnock?


Any reactions, please?
Thank you.


Regards,

Phil
