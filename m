Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVC1CEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVC1CEW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 21:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVC1CEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 21:04:22 -0500
Received: from irc.sh.nu ([216.239.132.110]:55274 "EHLO mail.3gstech.com")
	by vger.kernel.org with ESMTP id S261665AbVC1CET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 21:04:19 -0500
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!
From: Aaron Gyes <floam@sh.nu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 27 Mar 2005 18:04:17 -0800
Message-Id: <1111975457.24609.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-27 at 14:30 -0500, Kyle Moffett wrote:
> Well, under most interpretations of the GPL, you are *NOT* allowed to
> even _link_ non-GPL code with GPL code. (Basically, by distributing
> such a linked binary, you are certifying that you have permission to
> GPL the entire source-code and are doing so.
        
The code that is linked in the nvidia driver is open source. People can
and have easily adapted the free part of the driver to work on new
kernels. The 2.4 driver was ported to 2.6 with little trouble. The only
part that isn't open source is the binary that is wrapped.


> It's the difference between telling an artist to paint a big picture
> and watching every thought he makes while he does the painting with a
> brain scanner.

More crazy metaphores.. Obviously very complex things are being done, or
someone would have figured it out already.

