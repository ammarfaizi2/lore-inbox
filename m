Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284613AbRLPOLr>; Sun, 16 Dec 2001 09:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284619AbRLPOLi>; Sun, 16 Dec 2001 09:11:38 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:23036 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S284613AbRLPOLX>; Sun, 16 Dec 2001 09:11:23 -0500
From: David Lang <david.lang@digitalinsight.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 16 Dec 2001 05:45:54 -0800 (PST)
Subject: different behavior with 3c59x module vs built-in
Message-ID: <Pine.LNX.4.40.0112160540530.7706-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a dell laptop and am useing a 3com cardbus nic in it.

currently running 2.4.13 (but I don't remember seeing driver updates since
then for this driver)

If I compile the 3c59x driver into the kernel the nic does not work.
If I compile the driver as a module and load it manually the nic does work
it doesn't matter if I load the card first or insert the nic first, in
both cases the module needs to be loaded manually (even though the kernel
autoloader is enabled).

I'm on a relativly slow line until monday.

let me know if there is anything anyone wants me to try.

David Lang
