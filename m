Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271426AbTGQNpG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 09:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271428AbTGQNpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 09:45:06 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:30226 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S271426AbTGQNpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 09:45:04 -0400
Date: Thu, 17 Jul 2003 15:59:56 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: what's left for 64 bit dev_t
Message-ID: <20030717155956.A2364@pclin040.win.tue.nl>
References: <20030716184609.GA1913@kroah.com> <20030716130915.035a13ca.akpm@osdl.org> <20030716210253.GD2279@kroah.com> <20030716141320.5bd2a8b3.akpm@osdl.org> <20030716213607.GA2773@kroah.com> <20030716150010.6ba8416f.akpm@osdl.org> <20030716221154.GA3051@kroah.com> <20030716151939.1762a3cf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030716151939.1762a3cf.akpm@osdl.org>; from akpm@osdl.org on Wed, Jul 16, 2003 at 03:19:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 03:19:39PM -0700, Andrew Morton wrote:

> The situation at present is that Linus will take the patches,
> but I ain't sending them because viro has expressed oblique
> concerns over the approach.  I'd like to get his take on it
> before proceeding.  But he has vanished again.

Aha.  So, recently I diagnosed a deadlock, and this gives
some more insight in the nature of the deadlock.

It would be vaguely interesting to see these oblique concerns
dated and quoted.

