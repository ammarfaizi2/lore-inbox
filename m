Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271375AbTGQLko (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 07:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271381AbTGQLko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 07:40:44 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20430
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S271375AbTGQLkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 07:40:35 -0400
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       Andries Brouwer <aebr@win.tue.nl>, greg@kroah.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030717091515.GC19891@ca-server1.us.oracle.com>
References: <20030716210253.GD2279@kroah.com>
	 <20030716141320.5bd2a8b3.akpm@osdl.org> <20030716213451.GA1964@win.tue.nl>
	 <20030716143902.4b26be70.akpm@osdl.org> <20030716222015.GB1964@win.tue.nl>
	 <20030716152143.6ab7d7d3.akpm@osdl.org>
	 <20030717014410.A2026@pclin040.win.tue.nl>
	 <20030716164917.2a7a46f4.akpm@osdl.org>
	 <20030717082716.GA19891@ca-server1.us.oracle.com>
	 <Pine.LNX.4.44.0307171037070.717-100000@serv>
	 <20030717091515.GC19891@ca-server1.us.oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058442765.8620.28.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Jul 2003 12:52:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-17 at 10:15, Joel Becker wrote:
> 	Well, exporting devices over NFS is always tricky, because if
> the server isn't an identical OS, you can't even trust the numbers. 

NFSv3 fixed this.

