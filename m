Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312750AbSDKSuq>; Thu, 11 Apr 2002 14:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312772AbSDKSup>; Thu, 11 Apr 2002 14:50:45 -0400
Received: from ph.vub.ac.be ([134.184.129.2]:3571 "EHLO guppy.vub.ac.be")
	by vger.kernel.org with ESMTP id <S312750AbSDKSuo> convert rfc822-to-8bit;
	Thu, 11 Apr 2002 14:50:44 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Stijn Verrept <sverrept@vub.ac.be>
To: linux-kernel@vger.kernel.org
Subject: KVM Switch bug
Date: Thu, 11 Apr 2002 20:50:36 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200204112050.37043.sverrept@vub.ac.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When switching using a KVM switch I loose keyboard (only in Linux so it's not 
hardware related)

I'm using a ADDERView KVM switch (used to connect multiple PC's to one key / 
mouse / screen).  After looking on the internet I have found lots of other 
users having the same problem, with other KVM switches.
This happens both in console as in X.  Keyboard and mouse I use are both PS/2.

Using Linux version: 2.4.18-6mdk (gcc version 2.96 20000731)

I think anything else is pretty irrelavant.

Kind regards,

Stijn Verrept.

BTW Can I get any feedback on this?
