Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbTF2VHt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 17:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbTF2VHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 17:07:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:52167 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263633AbTF2VHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 17:07:46 -0400
Date: Sun, 29 Jun 2003 14:15:28 -0700 (PDT)
Message-Id: <20030629.141528.74734144.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: greearb@candelatech.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1056755070.5463.12.camel@dhcp22.swansea.linux.org.uk>
References: <3EFC9203.3090508@candelatech.com>
	<20030627.144426.71096593.davem@redhat.com>
	<1056755070.5463.12.camel@dhcp22.swansea.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 28 Jun 2003 00:04:30 +0100
   
   You are assuming there is a relationship in bug severity/commonness
   and number of *developers* who hit it.

Not true, the assumption I make is that a bug report that
a bug reporter cares about, and a patch that a patch submitter
cares about, will all get resent if they get dropped.

If the reporter/submitter doesn't care, neither do I.

You keep saying that lost information is bad and serves no
positive purpose, and I totally disagree.  Drops are litmus tests
for the patch/report, they also serve to educate the submitters.

And to repeat, this process is a two way street Alan.  If you try to
make it anything else, you will wear yourself thin.

Once you enforce the work to be distributed to the people who report
to you as much as to the people taking the reports, thing will go much
more smoothly. :-)
