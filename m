Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTDICI1 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 22:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbTDICI1 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 22:08:27 -0400
Received: from pcp749571pcs.manass01.va.comcast.net ([68.49.125.82]:48256 "EHLO
	charon.int.bittwiddlers.com") by vger.kernel.org with ESMTP
	id S261808AbTDICI0 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 22:08:26 -0400
Date: Tue, 8 Apr 2003 22:19:50 -0400
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: handle_scancode in 2.5.32+
Message-ID: <20030409021944.GA1464@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.68 (Shut Out)
X-Primary-Address: mharrell@bittwiddlers.com
Reply-To: Matthew Harrell 
	  <mharrell-dated-1050286790.515c12@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm working to fix a couple of external modules so they will work with later
2.5 kernels.  I've gotten the whole module building structure down fine but
I can't seem to find any examples or documentation on a possible replacement
for handle_scancode symbol that's accessible for a module.  Any help or 
recommendations?

-- 
  Matthew Harrell                          If at first you don't succeed,
  Bit Twiddlers, Inc.                       try management.
  mharrell@bittwiddlers.com     
