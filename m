Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbTDXN1L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 09:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263668AbTDXN1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 09:27:10 -0400
Received: from almesberger.net ([63.105.73.239]:60424 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S263665AbTDXN1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 09:27:09 -0400
Date: Thu, 24 Apr 2003 10:38:58 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030424103858.M3557@almesberger.net>
References: <1560860000.1051133781@flay> <20030423191427.D3557@almesberger.net> <1570840000.1051136330@flay> <20030424001134.GD26806@mail.jlokier.co.uk> <20030423214332.H3557@almesberger.net> <20030424011137.GA27195@mail.jlokier.co.uk> <20030423231149.I3557@almesberger.net> <25450000.1051152052@[10.10.2.4]> <20030424003742.J3557@almesberger.net> <20030424071439.GB28253@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424071439.GB28253@mail.jlokier.co.uk>; from jamie@shareable.org on Thu, Apr 24, 2003 at 08:14:39AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Yes, do make sure it is in there.

What's actually the exact statement ? Does anything change if you
don't switch from OSS to ALSA ?

Would something like this be correct ?


Sound
=====

ALSA
----

ALSA (Advanced Linux Sound Architecture) is now the preferred
architecture for sound support, instead of the older OSS (Open
Sound System). Note that all volume settings default to zero
in ALSA, so user space needs to explicitly increase the volume
before any sound can be heard.


- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
