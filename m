Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268586AbRGYQkZ>; Wed, 25 Jul 2001 12:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268590AbRGYQkG>; Wed, 25 Jul 2001 12:40:06 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:27003 "EHLO
	granite.internal") by vger.kernel.org with ESMTP id <S268586AbRGYQjq>;
	Wed, 25 Jul 2001 12:39:46 -0400
Date: Wed, 25 Jul 2001 11:42:00 -0500
From: Hollis Blanchard <hollis@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: relocating PCI host bridges
Message-ID: <20010725114200.A8584@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi, I need to relocate the memory space on my host bridge (the firmware puts
it in an inaccessible place). I've been going through the PCI code for a
while, but haven't found where I can do this. Is it possible?

Please cc me. Thanks!

-Hollis
