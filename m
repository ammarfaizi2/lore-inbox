Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265479AbTF1Xfs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 19:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265472AbTF1Xfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 19:35:48 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:33675
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265468AbTF1Xfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 19:35:47 -0400
Subject: Re: networking bugs and bugme.osdl.org
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: greearb@candelatech.com, davidel@xmailserver.org, mbligh@aracnet.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20030628.162002.48522400.davem@redhat.com>
References: <1056827972.6295.28.camel@dhcp22.swansea.linux.org.uk>
	 <20030628.150328.74739742.davem@redhat.com>
	 <1056842138.6753.16.camel@dhcp22.swansea.linux.org.uk>
	 <20030628.162002.48522400.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056844013.6778.42.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jun 2003 00:46:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-29 at 00:20, David S. Miller wrote:
> Now imagine if you invested this effort in educating people
> and getting them to be better bug reporters, sending the
> right info to the right place?

For IDE the statistical value of being able to go digging through old
data has been more than worth the effort. Similarly writing tools to do
the grovelling has a clear value.

> You're grovelling at the bottom of the barrel, it's time to start
> skimming from the top instead.  Things that matters will come back, it
> doesn't disappear.

I'm trying to turn grovelling into barrels into an automated process.
Thats much more useful and also entertaining (things like oops matching
and gdb trace matching turn out to be interesting little problems of
their own)

Alan

