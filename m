Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285006AbSABWAO>; Wed, 2 Jan 2002 17:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284886AbSABV7z>; Wed, 2 Jan 2002 16:59:55 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:5509 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S285006AbSABV7l>; Wed, 2 Jan 2002 16:59:41 -0500
Message-ID: <3C3382CA.3000503@allegientsystems.com>
Date: Wed, 02 Jan 2002 16:59:38 -0500
From: Nathan Bryant <nbryant@allegientsystems.com>
Organization: Allegient Systems
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, tom@infosys.tuwien.ac.at
Subject: [Fwd: i810_audio]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[oops, resending because i used the old lkml address by accident]

Hi Tom,

Can you have a look at Doug Ledford's 0.13 driver? this incorporates 
most or all of the fixes you mentioned, except for SiS support, and some 
other fixes; it hasn't been incorporated into the main kernel quite yet 
because it needs more testing.

it's located at http://people.redhat.com/dledford/i810_audio.c.gz

i've put a lot of work into this driver and i'd like to see everyone 
working on i810 code continue to work off a single base of source code 
rather than ending up with yet another fork...

thanx,
Nathan Bryant


