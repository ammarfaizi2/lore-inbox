Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265818AbTFSPsl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 11:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265819AbTFSPsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 11:48:41 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:47567 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265818AbTFSPsh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 11:48:37 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] sleep_decay for interactivity 2.5.72 - testers  needed
Date: Fri, 20 Jun 2003 02:02:37 +1000
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andreas Boman <aboman@midgaard.us>
References: <5.2.0.9.2.20030619171843.02299e00@pop.gmx.net>
In-Reply-To: <5.2.0.9.2.20030619171843.02299e00@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306200202.37745.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jun 2003 01:47, Mike Galbraith wrote:
> At 12:05 AM 6/20/2003 +1000, Con Kolivas wrote:
> >Testers required. A version for -ck will be created soon.
>
> That idea definitely needs some refinement.

Actually no it needs a bugfix even more than a refinement!

The best_sleep_decay should be 60, NOT 60*Hz

Con

