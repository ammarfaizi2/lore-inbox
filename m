Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271620AbRHZXIq>; Sun, 26 Aug 2001 19:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271573AbRHZXIh>; Sun, 26 Aug 2001 19:08:37 -0400
Received: from a1a90191.sympatico.bconnected.net ([209.53.18.14]:47332 "EHLO
	a1a90191.sympatico.bconnected.net") by vger.kernel.org with ESMTP
	id <S271621AbRHZXIW>; Sun, 26 Aug 2001 19:08:22 -0400
Date: Sun, 26 Aug 2001 16:08:37 -0700
From: Shane Wegner <shane@cm.nu>
To: linux-kernel@vger.kernel.org
Cc: Robert Love <rml@tech9.net>
Subject: patch: let net devices feed entropy for 2.2.19
Message-ID: <20010826160837.A24902@cm.nu>
In-Reply-To: <998196020.653.22.camel@phantasy> <998196489.653.27.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <998196489.653.27.camel@phantasy>
User-Agent: Mutt/1.3.20i
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In case anyone is interested, I have backported Robert
Love's netdev_random patch to the 2.2 kernel.  A patch
against 2.2.19 can be found at:
ftp://ftp.cm.nu/pub/people/shane/linux-2.2.19-netdev_random.patch.gz

Regards,
Shane

-- 
Shane Wegner: shane@cm.nu
              http://www.cm.nu/~shane/
PGP:          1024D/FFE3035D
              A0ED DAC4 77EC D674 5487
              5B5C 4F89 9A4E FFE3 035D
