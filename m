Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUCEQN6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 11:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbUCEQN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 11:13:58 -0500
Received: from ANancy-107-1-18-81.w81-48.abo.wanadoo.fr ([81.48.252.81]:11530
	"EHLO xiii.freealter.fr") by vger.kernel.org with ESMTP
	id S262634AbUCEQN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 11:13:56 -0500
Message-ID: <4048A73F.7030005@linbox.com>
Date: Fri, 05 Mar 2004 17:13:51 +0100
From: Ludovic Drolez <ldrolez@linbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: transmit timeouts with b44 and 2.6.2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

We have a bcm 4400 based NIC which has transmit timeouts with the b44 module. It 
works fine with broadcom's bcm4400 module and a 2.4.x module.

These bug entries,

http://bugzilla.kernel.org/show_bug.cgi?id=664
http://bugzilla.kernel.org/show_bug.cgi?id=257

seem to say that they are no problems left, but this card is still not working 
with my 2.6 kernel.

So is someone still working on the bugs ?
Why not integrating the bcm4400 module (GPLed) and droping this buggy b44 module ?

Regards,

-- 
Ludovic DROLEZ                                       Free&ALter Soft
152, rue de Grigy - Technopole Metz 2000                  57070 METZ
tel : 03 87 75 55 21                            fax : 03 87 75 19 26


