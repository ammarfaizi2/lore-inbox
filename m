Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270073AbTGNLAf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 07:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270077AbTGNLAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 07:00:35 -0400
Received: from raq465.uk2net.com ([213.239.56.46]:37125 "EHLO
	mail.truemesh.com") by vger.kernel.org with ESMTP id S270073AbTGNLAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 07:00:30 -0400
Date: Mon, 14 Jul 2003 12:09:09 +0100
From: Paul Nasrat <pauln@truemesh.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1: Hang during boot on Intel D865PERL motherboard
Message-ID: <20030714110909.GR28359@raq465.uk2net.com>
Mail-Followup-To: Paul Nasrat <pauln@truemesh.com>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	linux-kernel@vger.kernel.org
References: <20030714110311.6059.qmail@linuxmail.org> <20030714110335.GQ28359@raq465.uk2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714110335.GQ28359@raq465.uk2net.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 12:03:35PM +0100, Paul Nasrat wrote:
> On Mon, Jul 14, 2003 at 12:03:11PM +0100, Felipe Alfaro Solana wrote:
> > Hi,
> > 
> > I've compiled linux-2.6.0-test1 kernel with the attached "config" file. When trying to boot the kernel, it hangs on "Uncompress Linux kernel...OK". The system is:
> 
> You only have the dummy console selected ensuring you have:
> 
> CONFIG_CONSOLE_VGA=y

I should add please read:

http://codemonkey.org.uk/post-halloween-2.5.txt

Which documents this and other things to expect.

Paul
