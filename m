Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312484AbSCYSSS>; Mon, 25 Mar 2002 13:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312485AbSCYSSI>; Mon, 25 Mar 2002 13:18:08 -0500
Received: from octane12.nas.nasa.gov ([129.99.50.20]:47139 "EHLO
	octane12.nas.nasa.gov") by vger.kernel.org with ESMTP
	id <S312484AbSCYSSC>; Mon, 25 Mar 2002 13:18:02 -0500
Date: Mon, 25 Mar 2002 10:17:54 -0800 (PST)
From: Brian S Queen <bqueen@nas.nasa.gov>
Message-Id: <200203251817.KAA04773@octane12.nas.nasa.gov>
To: linux-kernel@vger.kernel.org
Subject: dnotify header question
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize if this is a repeat question.  I didn't see my own question
come by on the mailing list though.

I have been wondering how to get the new dnotify parts currently in
<linux/fcntl.h> into <fcntl.h>.  I have recompiled and entirley rebuilt
gcc with the --with-headers option in an effort to get it to
incorporate the new stuff from <linux/fcntl.h>.  Is this an false
expectation?  Do I have to submit the changes to the glibc folks to get
them into the <fcntl.h>?

Brian McQueen
NAS Division
NASA/Ames
