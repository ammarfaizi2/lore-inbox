Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbSKVRPM>; Fri, 22 Nov 2002 12:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265114AbSKVRPM>; Fri, 22 Nov 2002 12:15:12 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:64260 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S265096AbSKVRPL>; Fri, 22 Nov 2002 12:15:11 -0500
Message-ID: <3DDE67DB.C66E43D3@aitel.hist.no>
Date: Fri, 22 Nov 2002 18:22:35 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.47 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au, viro@math.psu.edu
Subject: 2.5.48-bk4 still impossible to mount root.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

None of the 2.5.48- bk or mm kernels lets me mount root,
while 2.5.47 works fine.  It doesn't matter wether it is
a smp machine with scsi raid-1 or a up with plain ide.

Possibly some devfs change that went into 2.5.48?
I have been using devfs for a long time now. Most
people don't, and they seems able to run 2.5.48.


Helge Hafting
