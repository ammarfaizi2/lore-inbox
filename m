Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263746AbTDYKwL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 06:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263874AbTDYKwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 06:52:11 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29575
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263746AbTDYKwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 06:52:10 -0400
Subject: Re: [Bug 623] New: Volume not remembered.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Werner Almesberger <wa@almesberger.net>
Cc: Pat Suwalski <pat@suwalski.net>, Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030425074116.V3557@almesberger.net>
References: <20030423214332.H3557@almesberger.net>
	 <20030424011137.GA27195@mail.jlokier.co.uk>
	 <20030423231149.I3557@almesberger.net> <25450000.1051152052@[10.10.2.4]>
	 <20030424003742.J3557@almesberger.net>
	 <20030424071439.GB28253@mail.jlokier.co.uk>
	 <20030424103858.M3557@almesberger.net>
	 <20030424213632.GK30082@mail.jlokier.co.uk>
	 <20030424205515.T3557@almesberger.net> <3EA87BE1.1070107@suwalski.net>
	 <20030425074116.V3557@almesberger.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051265094.5573.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Apr 2003 11:04:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-04-25 at 11:41, Werner Almesberger wrote:
> Okay, so there is a case for OSS. Not sure who is maintaining it,
> and if they care about making it act like ALSA. It would certainly
> be nice to be consistent, and I'm sure that OSS users won't mind
> getting rid of the occasional rude wakeup call.

The OSS audio drivers ac97 code now starts up with record muted. 

