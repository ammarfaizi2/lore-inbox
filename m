Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315091AbSENCVZ>; Mon, 13 May 2002 22:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315101AbSENCVY>; Mon, 13 May 2002 22:21:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17634 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315091AbSENCVY>;
	Mon, 13 May 2002 22:21:24 -0400
Date: Mon, 13 May 2002 19:08:09 -0700 (PDT)
Message-Id: <20020513.190809.97007595.davem@redhat.com>
To: andrew.grover@intel.com
Cc: mochel@osdl.org, jgarzik@mandrakesoft.com, Greg@kroah.com,
        linux-kernel@vger.kernel.org
Subject: Re: pci segments/domains
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7E45@orsmsx111.jf.intel.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Grover, Andrew" <andrew.grover@intel.com>
   Date: Mon, 13 May 2002 19:07:23 -0700

   I don't care what they're called, but I wanted to bring them up and see what
   everyone thought about how best to implement them, or at least if anyone had
   an objection to adding a "segment" parameter to pci_scan_root.
   
   I certainly don't have a machine that uses these but some people do, and it
   sounds like it would be nice to handle them in an arch-neutral way.

What exactly doesn't work right now?  I've been using multi-PCI-domain
systems for years under Linux :-)
