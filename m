Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTEVUlu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 16:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbTEVUlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 16:41:50 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:63170 "EHLO
	server0027.freedom2surf.net") by vger.kernel.org with ESMTP
	id S261820AbTEVUlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 16:41:49 -0400
Date: Thu, 22 May 2003 21:54:53 +0100
From: Ian Molton <spyro@f2s.com>
To: linux-kernel@vger.kernel.org
Subject: IDE
Message-Id: <20030522215453.3ae68b6f.spyro@f2s.com>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I've got an old IDE disc (Quantum Maverick 270A) and it appears to be
detected OK, however I get about 15 hda: lost interrupt between
detection and printing the partition table (which seems to go OK).

this is on 2.5.69, with my own IDE driver (which I ported from 2.4.16)

any ideas? I heard 2.5 doesnt like some very old drives...

-- 
Spyros lair: http://www.mnementh.co.uk/
Do not meddle in the affairs of Dragons, for you are tasty and good with
ketchup.

Systems programmers keep it up longer.
