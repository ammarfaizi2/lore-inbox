Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264227AbTDWVWq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 17:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264230AbTDWVWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 17:22:46 -0400
Received: from almesberger.net ([63.105.73.239]:3334 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S264227AbTDWVWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 17:22:45 -0400
Date: Wed, 23 Apr 2003 18:34:13 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030423183413.C1425@almesberger.net>
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508310000.1051116963@flay>; from mbligh@aracnet.com on Wed, Apr 23, 2003 at 09:56:03AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> Actually, I agree with the submitter. Having the volume default to 0
> is stupid - userspace tools are all very well, but no substitute for
> sensible kernel defaults.

You've obviously never been to a meeting/conference and booted
a Linux notebook with a kernel that sets things to a non-zero
default :-)

If the default is to turn up also the microphone (and to enable
it in the first place), you might notice that even apparently
weak speakers are perfectly capable of producing a very LOUD
alarm-like sound. And you'll have to sit through this until
your user-mode utility loads and turns the mess off, while
everybody is turning to stare at you.

0 is the only safe default setting.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
