Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131309AbRDBU0Q>; Mon, 2 Apr 2001 16:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131316AbRDBU0H>; Mon, 2 Apr 2001 16:26:07 -0400
Received: from postal.ic.sunysb.edu ([129.49.1.24]:36750 "EHLO
	mail.ic.sunysb.edu") by vger.kernel.org with ESMTP
	id <S131309AbRDBUZw>; Mon, 2 Apr 2001 16:25:52 -0400
Date: Mon, 2 Apr 2001 16:25:11 -0400 (EDT)
From: Fu-hau Hsu <fhsu@ic.sunysb.edu>
To: linux-kernel@vger.kernel.org
cc: Fu-hau Hsu <fhsu@ic.sunysb.edu>
Subject: Memory maps
Message-ID: <Pine.GSO.4.21.0104021611050.24682-100000@sparky.ic.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear freinds:

 I have following questions about memory maps. I appreciate any
suggestion.

 Q. (1)When a process is running, how can I get the range of data, stack,
       and code segments, say the stack segment is from address 0x..... to
       0x..... so do data segments and code segments?
       PS: Under ELF format, there are several seperaed code and data
           segments, but the process control table has only one pair of
           pointers for each, Are the pointers still useful?
    
    (2) /proc/*/maps will show us those info, but how does it get these
       info? 


FuHau 

