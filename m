Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263405AbTCNR3l>; Fri, 14 Mar 2003 12:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263407AbTCNR3l>; Fri, 14 Mar 2003 12:29:41 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:45561 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263405AbTCNR3h> convert rfc822-to-8bit;
	Fri, 14 Mar 2003 12:29:37 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.64 ttyS problem ?
Date: Fri, 14 Mar 2003 09:37:04 -0800
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200303140937.04049.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any one see this problem ? Is it a known problem ?
How do I fix this ? I am running 2.5.64.

# minicom
Device /dev/ttyS1 lock failed: No child processes.

# ls -l /dev/ttyS1
crw-rw----    1 root     uucp       4,  65 Mar 14 10:23 /dev/ttyS1

# echo "test" > /dev/ttyS1
#

Thanks,
Badari

