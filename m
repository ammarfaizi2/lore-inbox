Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281039AbRKGWtj>; Wed, 7 Nov 2001 17:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281040AbRKGWta>; Wed, 7 Nov 2001 17:49:30 -0500
Received: from mx3.port.ru ([194.67.57.13]:56594 "EHLO smtp3.port.ru")
	by vger.kernel.org with ESMTP id <S281039AbRKGWtR>;
	Wed, 7 Nov 2001 17:49:17 -0500
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200111072251.fA7Mp5e16733@vegae.deep.net>
Subject: Laptop harddisk spindown?
To: linux-kernel@vger.kernel.org
Date: Thu, 8 Nov 2001 01:51:05 +0300 (MSK)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     I`m sorry folks, i dont quite recall whether i poked lkml with that,
  but here it is:
	2.4.13, reiserfs
	i have a disk access _every_ 5 sec, unregarding the system load, 
    24x7x365, so i suppose while it doesnt hurts me, it hurts folks with power
    bound boxes...
        I must add that i `m experiencing this on -ac tree too, adn this is true
    as far as my memory goes... (in the kernel-version context i mean)

cheers, Samium Gromoff
 
