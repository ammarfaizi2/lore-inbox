Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263790AbTDXWX7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 18:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbTDXWX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 18:23:59 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:25224 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263790AbTDXWX4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 18:23:56 -0400
Date: Thu, 24 Apr 2003 23:36:04 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Downing, Thomas" <Thomas.Downing@ipc.com>
Cc: Daniel Phillips <phillips@arcor.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
Message-ID: <20030424223604.GA31179@mail.jlokier.co.uk>
References: <170EBA504C3AD511A3FE00508BB89A9201FD9247@exnanycmbx4.ipc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170EBA504C3AD511A3FE00508BB89A9201FD9247@exnanycmbx4.ipc.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Downing, Thomas wrote:
> How does the server _know_ that the BIOS is what it says it is? Again,
> what's the protocol?  Saying that they 'have a chat' is bypassing
> the hard bits.
> 
> If I have the BIOS, any secrets it holds are now knowable to me.
> This means that any protocol that relies on a secret in the BIOS is
> broken from the start.  So now you need to define a protocol which
> does not rely on any secret being known to the BIOS.  What is this
> protocol?

What makes you think you can read the BIOS?

> The proposed 'end-to-end' copy protection schemes for entertainment
> media etc, rely on proprietary _hardware_.

Yes, that's the severe version of DRM that we're talking about, for
the game server scenario.

> This is still beatable, although at a higher cost.  Nor is the
> problem quite parallel.  The broadcast problem is 'how do we keep
> content encrypted till the last possible moment?' and 'how do we
> keep the decryption engine tamper proof reverse engineering proof'.
> The first part is easy.  The second part is not possible in an
> absolute sense.  It can only be made more or less dificult.  Hence
> the DMCA etc.

We don't know for sure that it's not possible to make something
reverse engineering proof.  Although all current CPUs require code to
be decrypted at some point, there may be modules of computation that
don't require that, so there would be no way to extract the secret key
or decryption process in a useful way even when you can see every
electronic signal in a device.  The jury is out on it, despite what
slashdotters believe.

-- Jamie
