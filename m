Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbSJFWUi>; Sun, 6 Oct 2002 18:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262230AbSJFWUi>; Sun, 6 Oct 2002 18:20:38 -0400
Received: from grunt2.ihug.co.nz ([203.109.254.42]:55442 "EHLO
	grunt2.ihug.co.nz") by vger.kernel.org with ESMTP
	id <S262224AbSJFWUh> convert rfc822-to-8bit; Sun, 6 Oct 2002 18:20:37 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: cll muzh <muzh@ihug.co.nz>
Organization: -
To: mec@shout.net
Subject: Make menu config crash when trying to configure ALSA modules
Date: Mon, 7 Oct 2002 11:27:25 +1300
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210071127.25952.muzh@ihug.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
While running make menuconfig on a 2.5.40 kernel (constructed from stock 
2.5.31 + stock patches) I received an immediate crash and exit while trying 
to enter Sound --> Advanced Linux Sound Architecture.
The error reported was :

Q> ./scripts/Menuconfig: MCmenu74: command not found

I am just reporting this as advised in the crash report --
Best wishes, Peter Keller.

-- 
This mail is certified Virus-free as no Microsoft products were used in its 
preparation or propagation
