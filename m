Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264494AbTDXXoD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTDXXns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:43:48 -0400
Received: from almesberger.net ([63.105.73.239]:2059 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S264494AbTDXXn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:43:26 -0400
Date: Thu, 24 Apr 2003 20:55:15 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030424205515.T3557@almesberger.net>
References: <1570840000.1051136330@flay> <20030424001134.GD26806@mail.jlokier.co.uk> <20030423214332.H3557@almesberger.net> <20030424011137.GA27195@mail.jlokier.co.uk> <20030423231149.I3557@almesberger.net> <25450000.1051152052@[10.10.2.4]> <20030424003742.J3557@almesberger.net> <20030424071439.GB28253@mail.jlokier.co.uk> <20030424103858.M3557@almesberger.net> <20030424213632.GK30082@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424213632.GK30082@mail.jlokier.co.uk>; from jamie@shareable.org on Thu, Apr 24, 2003 at 10:36:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> I.e. if silence is the load-time setting, the OSS drivers and other
> non-ALSA sound drivers should be changed to do that as well.

Yes, unless we really consider everything but ALSA to be obsolete
to the point of irrelevance.

Or, to phrase this as a question, how likely is it that somebody
will prefer OSS over ALSA ? (E.g. because there is no ALSA driver,
the ALSA driver doesn't work, some application doesn't work with
ALSA, etc.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
