Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbTI1CjK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 22:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbTI1CjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 22:39:10 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:9912 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262304AbTI1CjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 22:39:09 -0400
From: Andrew Miklas <public@mikl.as>
Reply-To: public@mikl.as
To: linux-kernel@vger.kernel.org
Subject: RE: LInksys WMP11 (BCM4301 chip)
Date: Sat, 27 Sep 2003 22:38:50 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309272238.50475.public@mikl.as>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

David Ford wrote:

> According to http://www.linuxworld.com/story/33804.htm, (Andrew Miklas),
> the BCM4301 is supported however I don't see any such critter in my
> source.

The link mentioned quotes me as saying that the BCM4300 series of wireless 
chips has excellent support on the MIPS architecture, which indeed it does. 
Unfortunately, what they don't mention is that the source for that driver was 
not, and has not been released by Linksys or Broadcom.  Also, the binary 
driver is only available in the firmware of networking products, like the 
WRT54G, using Broadcom wireless chips.

Hopefully, I'll have some more information to post here about that in the 
coming few days.


-- Andrew
