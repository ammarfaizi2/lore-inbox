Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269223AbRHMQQD>; Mon, 13 Aug 2001 12:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270271AbRHMQPx>; Mon, 13 Aug 2001 12:15:53 -0400
Received: from teranet244-12-200.monarch.net ([24.244.12.200]:38650 "HELO
	lustre.dyn.ca.clusterfilesystem.com") by vger.kernel.org with SMTP
	id <S269223AbRHMQPg>; Mon, 13 Aug 2001 12:15:36 -0400
Date: Mon, 13 Aug 2001 10:15:01 -0600
From: "Peter J. Braam" <braam@clusterfilesystem.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.8-ac2 USB keyboard capslock hang
Message-ID: <20010813101501.A1451@lustre.dyn.ca.clusterfilesystem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Logitech Internet USB keyboard, attached to an IBM TP T20. 

In the above system pressing Caps lock twice (i.e. switching capslock
off) freezes the system completely. 

The last system that didn't do so for me was Rosswell's kernel. 

Does anyone know about this?  Thanks a lot!

- Peter -
