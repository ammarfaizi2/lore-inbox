Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbTF2Vz5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 17:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbTF2Vz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 17:55:56 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44430
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265085AbTF2Vzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 17:55:55 -0400
Subject: Re: networking bugs and bugme.osdl.org
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: greearb@candelatech.com, mbligh@aracnet.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20030629.141528.74734144.davem@redhat.com>
References: <3EFC9203.3090508@candelatech.com>
	 <20030627.144426.71096593.davem@redhat.com>
	 <1056755070.5463.12.camel@dhcp22.swansea.linux.org.uk>
	 <20030629.141528.74734144.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056924426.16255.24.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jun 2003 23:07:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-29 at 22:15, David S. Miller wrote:
> You keep saying that lost information is bad and serves no
> positive purpose, and I totally disagree.  Drops are litmus tests
> for the patch/report, they also serve to educate the submitters.

What you don't get is that like you I'm distributing work. I'm getting
end users to spot bug correlations - and thats why I want better tools

Report bug should get
Your bug looks like #1131 #4151 or #11719 (Resolved), please check 

