Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWHKLlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWHKLlE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 07:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWHKLlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 07:41:04 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:55977 "EHLO
	smtprelay05.ispgateway.de") by vger.kernel.org with ESMTP
	id S932159AbWHKLlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 07:41:02 -0400
From: Matthias Dahl <mlkernel@mortal-soul.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: sluggish system responsiveness under higher IO load
Date: Fri, 11 Aug 2006 13:40:41 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200608061200.37701.mlkernel@mortal-soul.de> <20060808190241.GB11829@suse.de> <20060810122853.GS11829@suse.de>
In-Reply-To: <20060810122853.GS11829@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608111340.41247.mlkernel@mortal-soul.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 August 2006 14:28, Jens Axboe wrote:

> - Did 2.6.16 work well for you?

AFAICT 2.6.17 behaved more sluggish but this is my subjective observation. The 
problem itself exists for quite some time now. (prior to 2.6.16) I cannot 
even tell if it ever worked fine. :-(

> - Does disabling preemtion (CONFIG_PREEMPT_NONE=y) help?

Sorry for my late response btw. I will do the necessary tests (including the 
blktrace you asked for) this weekend and report back as soon as possible.
