Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031135AbWI0Wqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031135AbWI0Wqe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbWI0Wqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:46:34 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:13003 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964890AbWI0Wqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:46:33 -0400
Message-ID: <451AFF47.2090705@pobox.com>
Date: Wed, 27 Sep 2006 18:46:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net
Subject: Re: [patch 0/2] libata: Return of the ACPI Patches
References: <20060927153619.b4126a63.kristen.c.accardi@intel.com>
In-Reply-To: <20060927153619.b4126a63.kristen.c.accardi@intel.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristen Carlson Accardi wrote:
> Hello,
> These are patches that use ACPI to help reinitialize SATA drivers
> on resume.  They were created and first submitted by Randy Dunlap last
> year, and then again by Forrest Zhao a couple months ago.  And now it's
> my turn.  These are against 2.6.18-mm1 - please let me know if you want
> me to patch against a different code base.  Hopefully I've captured all
> the past feedback, but sorry in advance if I've missed something that's
> been said before.

Yay!  I'm quite happy this is still alive.  Comments to follow...

	Jeff



