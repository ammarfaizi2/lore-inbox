Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290756AbSBSJDO>; Tue, 19 Feb 2002 04:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290794AbSBSJDF>; Tue, 19 Feb 2002 04:03:05 -0500
Received: from smtp02do.de.uu.net ([192.76.144.69]:55689 "EHLO
	smtp02do.de.uu.net") by vger.kernel.org with ESMTP
	id <S290756AbSBSJC5> convert rfc822-to-8bit; Tue, 19 Feb 2002 04:02:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: Tobias Wollgam <tobias.wollgam@materna.de>
Organization: Materna GmbH
To: linux-kernel@vger.kernel.org
Subject: Q: use of new modules in old kernel
Date: Tue, 19 Feb 2002 10:02:52 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Encoded: Changed encoding from 8bit for 7bit transmission
Message-Id: <20020219090253.CD89D67ED@penelope.materna.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

how is it possible to use modules of newer kernels in an old kernel 
system?

To use new drivers, we want not recompile the kernel.

I tried to load the module 8139too from 2.4.17 into a 2.4.9 kernel with 
modprobe, but there are many unresolved symbols. 

The flag "Set version information on all module symbols" is set.

TIA for all information, hyperlinks are welcome too,

	Tobias

-- 
Tobias Wollgam * Softwaredevelopment * Business Unit Information 
MATERNA GmbH Information & Communications
Vosskuhle 37 * 44141 Dortmund  
http://www.materna.de
