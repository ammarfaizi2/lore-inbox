Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262504AbUKQSm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbUKQSm0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUKQSkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:40:12 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:50186 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262491AbUKQSh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:37:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=n2AZDs8vps+qE31hlkoiNzi5sjb7Cy2PQ26Diy47y9soRy0CzTNJ/UkQZRlcj/JSXbY/ZNUg2FAs/M4BEXA78TOLfe+1cDs9kvUbzumLA7PD3AExpkG60jCYtV8ptX+JdY+rB99b14xF8bkzDlKYmlrX4YBnFhYDVWWAxaRhb/I=
Message-ID: <cc61bb420411171037369a930e@mail.gmail.com>
Date: Wed, 17 Nov 2004 13:37:58 -0500
From: Robert Harris <robert.l.harris@gmail.com>
Reply-To: Robert Harris <robert.l.harris@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Date/Time problems on an IBM Desktop ? (P4-2.8ghz)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm testing the 2.4.27 kernel on an IBM ThinkCentre A30 Desktop.  The
system has a P4 2.8Ghz processor, 512 Megs of ram and IDE disk.  The
clock on the system is very much off.  Using the "/bin/date" command
it seems to actually count 1 second for every 10 or so.  Under load
this can be even slower.  I've reproduced this on 3 separate pieces of
hardware.

Has anyone run into this or have an idea?  My next step is to try an
older kernel with the same config but that may take a bit to get built
and tested.

Robert
-- 

:wq!
---------------------------------------------------------------------------
Robert L. Harris

DISCLAIMER:
      These are MY OPINIONS             With Dreams To Be A King,
       ALONE.  I speak for              First One Should Be A Man
       no-one else.                       - Manowar
