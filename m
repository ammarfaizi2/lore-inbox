Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTD3QIh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 12:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbTD3QIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 12:08:37 -0400
Received: from ltgp.iram.es ([150.214.224.138]:40584 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S262193AbTD3QIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 12:08:36 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 30 Apr 2003 18:15:25 +0200
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jamie Lokier <jamie@shareable.org>, Andi Kleen <ak@suse.de>,
       joe briggs <jbriggs@briggsmedia.com>, linux-kernel@vger.kernel.org
Subject: Re: software reset
Message-ID: <20030430161525.GA3834@iram.es>
References: <200304291037.13598.jbriggs@briggsmedia.com.suse.lists.linux.kernel> <p73vfwx2uw8.fsf@oldwotan.suse.de> <20030430075004.GB13859@mail.jlokier.co.uk> <m1llxsfdpg.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1llxsfdpg.fsf@frodo.biederman.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 05:04:59AM -0600, Eric W. Biederman wrote:
> 
> And as an interesting data point all a triple fault does on a modern
> system is to put the cpu in a weird stopped state.  Some hardware
> usually the southbridge then detects this and if properly configured
> will trigger the reset line.
> 
> I believe this may actually go back into history as far as the 486 but
> I have not done the researched to see how far back this behavior goes.

Try 286. It was the fastest (actually only) way to make a 286 switch back
from protected to real mode.

	Gabriel
