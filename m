Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbTDXHCn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 03:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbTDXHCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 03:02:43 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:43655 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261320AbTDXHCm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 03:02:42 -0400
Date: Thu, 24 Apr 2003 08:14:39 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Werner Almesberger <wa@almesberger.net>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030424071439.GB28253@mail.jlokier.co.uk>
References: <20030423183413.C1425@almesberger.net> <1560860000.1051133781@flay> <20030423191427.D3557@almesberger.net> <1570840000.1051136330@flay> <20030424001134.GD26806@mail.jlokier.co.uk> <20030423214332.H3557@almesberger.net> <20030424011137.GA27195@mail.jlokier.co.uk> <20030423231149.I3557@almesberger.net> <25450000.1051152052@[10.10.2.4]> <20030424003742.J3557@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424003742.J3557@almesberger.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> (Besides, you've just added the "silent" flag as another config item
> besides the volume setting, using different interfaces, different
> permissions, etc.)

Eh?  Another?

> As far as those are concerned who painstakingly build their own
> kernel, update the things listed in Documentation/Changes, avoid
> suble traps like CONFIG_SERIO_I8042, don't get confused by needing
> new module utilities, etc., I'm fairly confident that they'll
> consider setting the volume a rather minor challenge.

Heh, you got it right there with 8042 et al. :)

> And you could even take the sting out of this one by adding an
> appropriate warning to Documentation/Changes. That's a about all
> the kernel-side support this issue deserves.

Yes, do make sure it is in there.

-- Jamie
