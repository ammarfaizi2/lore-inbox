Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751525AbWIFTW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbWIFTW0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 15:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbWIFTW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 15:22:26 -0400
Received: from ns.suse.de ([195.135.220.2]:27800 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751501AbWIFTWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 15:22:25 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] x86_64 kexec: Remove experimental mark of kexec
Date: Wed, 6 Sep 2006 21:22:14 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org
References: <m1veo1vtev.fsf@ebiederm.dsl.xmission.com> <m1k64hvsru.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1k64hvsru.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609062122.14971.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 September 2006 18:55, Eric W. Biederman wrote:
> 
> kexec has been marked experimental for a year now and all
> of the serious problems have been worked through.  So it
> is time (if not past time) to remove the experimental mark.
> 

Hmm, I personally have some doubts it is really not experimental
(not because of the kexec code itself, but because of all the other drivers
that still break)

But applied for now.

-Andi
