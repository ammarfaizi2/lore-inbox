Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTIWR4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 13:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbTIWR4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 13:56:44 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:60325 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262228AbTIWR4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 13:56:43 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg Stark <gsstark@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: ICH5-SATA drivers freeze system when drives are spun down
References: <87k77zqv1s.fsf@stark.dyndns.tv> <20030923174613.GA27629@gtf.org>
In-Reply-To: <20030923174613.GA27629@gtf.org>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 23 Sep 2003 13:56:42 -0400
Message-ID: <878yofqtgl.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik <jgarzik@pobox.com> writes:

> Are you using my libata driver, or the stock drivers/ide driver?

The stock drivers from 2.4.23-pre4

What should I be using? Where do I get your driver?

> The stock drivers/ide ICH5 SATA driver in known to lock up in many
> cases, not just the one you described.

Then I guess I've been lucky so far.

-- 
greg

