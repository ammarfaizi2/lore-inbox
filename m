Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbTDXBKX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 21:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264359AbTDXBKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 21:10:23 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:57216 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S264346AbTDXBKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 21:10:22 -0400
Message-ID: <3EA73C54.3020201@suwalski.net>
Date: Wed, 23 Apr 2003 21:22:28 -0400
From: Pat Suwalski <pat@suwalski.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030331
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
Cc: Werner Almesberger <wa@almesberger.net>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423183413.C1425@almesberger.net> <1560860000.1051133781@flay> <20030423191427.D3557@almesberger.net> <1570840000.1051136330@flay> <20030424001134.GD26806@mail.jlokier.co.uk> <20030423214332.H3557@almesberger.net> <20030424011137.GA27195@mail.jlokier.co.uk>
In-Reply-To: <20030424011137.GA27195@mail.jlokier.co.uk>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> In fact, forget about "volume".  Just have a "silent" parameter that
> defaults to 0, and determines whether the device starts silent or
> loads preset defaults.  Make it a core audio thing rather than a
> per-driver thing, too.  "silent=1" in /etc/modules.conf self-evidently
> answers the FAQ, too :)

That is veryt true. Self-answering FAQs are nice.

This thread... what a monstrosity I started...

--Pat


