Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVBCG7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVBCG7c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 01:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbVBCG7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 01:59:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15851 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262520AbVBCG7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 01:59:20 -0500
Date: Wed, 2 Feb 2005 22:59:11 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Peter Osterlund <petero2@telia.com>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org, dtor_core@ameritech.net,
       zaitcev@redhat.com
Subject: Re: Touchpad problems with 2.6.11-rc2
Message-ID: <20050202225911.7efc0db4@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.58.0502022345320.18555@telia.com>
References: <20050123190109.3d082021@localhost.localdomain>
	<m3acqr895h.fsf@telia.com>
	<20050201234148.4d5eac55@localhost.localdomain>
	<m3lla64r3w.fsf@telia.com>
	<20050202141117.688c8dd3@localhost.localdomain>
	<Pine.LNX.4.58.0502022345320.18555@telia.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 23:58:05 +0100 (CET), Peter Osterlund <petero2@telia.com> wrote:

> It didn't make any difference for the generated assembly code though,
> using gcc 3.4.2 from Fedora Core 3.

OK, unary minus is fine then.

What about using 'value' in place of 'fx(0)'?

-- Pete
