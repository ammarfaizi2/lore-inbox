Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282606AbRKZWRD>; Mon, 26 Nov 2001 17:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282607AbRKZWQ5>; Mon, 26 Nov 2001 17:16:57 -0500
Received: from waste.org ([209.173.204.2]:27329 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S282606AbRKZWQr>;
	Mon, 26 Nov 2001 17:16:47 -0500
Date: Mon, 26 Nov 2001 16:18:58 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Default outgoing IP address?
Message-ID: <Pine.LNX.4.40.0111261612390.15983-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a machine with multiple interfaces, is it possible to set the default
outgoing IP address to something other than the address for the interface
on the outgoing route?

For instance, a machine acts as a gateway, with addresses A and B, where A
faces the world (but isn't in DNS) and B is the canonical address.
Outgoing connections from the machine should appear to come from B.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

