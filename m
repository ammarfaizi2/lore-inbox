Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265679AbSJSUzs>; Sat, 19 Oct 2002 16:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265680AbSJSUzs>; Sat, 19 Oct 2002 16:55:48 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:37875 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S265679AbSJSUzr>; Sat, 19 Oct 2002 16:55:47 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Eric Altendorf <EricAltendorf@orst.edu>
Reply-To: EricAltendorf@orst.edu
To: linux-kernel@vger.kernel.org
Subject: ACPI Toshiba-extras LCD backlight control not working anymore?
Date: Fri, 18 Oct 2002 15:28:38 -0700
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210181528.38731.EricAltendorf@orst.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I can see the brightness levels:
  [eric@localhost eric]$ cat /proc/acpi/toshiba/lcd
  brightness:              5
  brightness_levels:       8

but I cannot change them.  Values echoed to the file are silently 
ignored.

This used to work many versions ago (maybe 2.5.25, I don't recall).  
It hasn't worked since 2.5.38, at least.  Anyone know what happened?

Eric

-- 
"First they ignore you.  Then they laugh at you.
 Then they fight you.  And then you win."             -Gandhi


