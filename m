Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264904AbTF0Wx2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 18:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264900AbTF0Wx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 18:53:27 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:22665
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264899AbTF0WxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 18:53:24 -0400
Subject: Re: networking bugs and bugme.osdl.org
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: greearb@candelatech.com, mbligh@aracnet.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20030627.144426.71096593.davem@redhat.com>
References: <18330000.1056692768@[10.10.2.4]>
	 <20030626.224739.88478624.davem@redhat.com>
	 <3EFC9203.3090508@candelatech.com>
	 <20030627.144426.71096593.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056755070.5463.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Jun 2003 00:04:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-06-27 at 22:44, David S. Miller wrote:
> This work for kernel patches, and has so for over 5 years.
> So what makes anyone thing it doesn't work for bug reporting?

It works badly for kernel patches, stuff does get lost forever, missed
etc. Having it all archived somewhere is really valuable because it
means you can spot patterns, trends and also when someone who isnt a
hacker hits the bug *they* can find the patch you missed and send it on
or remind you

You are assuming there is a relationship in bug severity/commonness and
number of *developers* who hit it. That isnt true, developer and end
user hardware patterns are radically different in some areas

