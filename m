Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVDDDEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVDDDEP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 23:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVDDDEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 23:04:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35010 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261394AbVDDDEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 23:04:13 -0400
Date: Sun, 3 Apr 2005 23:03:34 -0400
From: Dave Jones <davej@redhat.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Luca Falavigna <dktrkranz@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kaos@ocs.com.au
Subject: Re: [PATCH] RCU in kernel/intermodule.c
Message-ID: <20050404030334.GB433@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	Luca Falavigna <dktrkranz@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kaos@ocs.com.au
References: <424E81CC.6000600@gmail.com> <a127bbd121b274b7adb7e71b42979e4b@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a127bbd121b274b7adb7e71b42979e4b@mac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2005 at 01:38:33PM -0400, Kyle Moffett wrote:

 > Also, the intermodule stuff is slated for removal, as soon as MTD and
 > such are fixed; the interface has been deprecated for a while.

Actually 'just' mtd now iirc. agpgart was the penultimate user which
got fixed a few months back.

		Dave

