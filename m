Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263857AbTDYK3a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 06:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263858AbTDYK33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 06:29:29 -0400
Received: from almesberger.net ([63.105.73.239]:33804 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S263857AbTDYK32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 06:29:28 -0400
Date: Fri, 25 Apr 2003 07:41:16 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Pat Suwalski <pat@suwalski.net>
Cc: Jamie Lokier <jamie@shareable.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030425074116.V3557@almesberger.net>
References: <20030423214332.H3557@almesberger.net> <20030424011137.GA27195@mail.jlokier.co.uk> <20030423231149.I3557@almesberger.net> <25450000.1051152052@[10.10.2.4]> <20030424003742.J3557@almesberger.net> <20030424071439.GB28253@mail.jlokier.co.uk> <20030424103858.M3557@almesberger.net> <20030424213632.GK30082@mail.jlokier.co.uk> <20030424205515.T3557@almesberger.net> <3EA87BE1.1070107@suwalski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA87BE1.1070107@suwalski.net>; from pat@suwalski.net on Thu, Apr 24, 2003 at 08:05:53PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pat Suwalski wrote:
> For that, refer to my other bug: 
> http://bugzilla.kernel.org/show_bug.cgi?id=622

Okay, so there is a case for OSS. Not sure who is maintaining it,
and if they care about making it act like ALSA. It would certainly
be nice to be consistent, and I'm sure that OSS users won't mind
getting rid of the occasional rude wakeup call.

(Oh, another nice scenario: if they ask you to turn on your
notebook at airport security. Great setting for demonstrating that
loud alarm-like feedback loop :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
