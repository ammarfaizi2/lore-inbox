Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265898AbUF2SiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265898AbUF2SiA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 14:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265906AbUF2Sh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 14:37:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11721 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265897AbUF2Sh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 14:37:58 -0400
Date: Tue, 29 Jun 2004 14:37:32 -0400
From: Alan Cox <alan@redhat.com>
To: Byron Stanoszek <gandalf@winds.org>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: PATCH: Further aacraid work
Message-ID: <20040629183732.GA3243@devserv.devel.redhat.com>
References: <20040616210455.GA13385@devserv.devel.redhat.com> <Pine.LNX.4.60.0406291344195.26319@winds.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0406291344195.26319@winds.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 01:48:39PM -0400, Byron Stanoszek wrote:
> Linux version 2.6.7 (gcc version 3.4.0) #3 SMP Tue Jun 29 13:23:58 EDT 2004

Never tested with gcc 3.4 but that ought no to matter. The normal cause
for that kind of error is the firmware stopping responding. Make sure
you have current firmware updates as a starting point



