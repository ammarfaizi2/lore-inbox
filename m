Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279580AbRKFOzh>; Tue, 6 Nov 2001 09:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279575AbRKFOz3>; Tue, 6 Nov 2001 09:55:29 -0500
Received: from gap.cco.caltech.edu ([131.215.139.43]:46763 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S279581AbRKFOzN>; Tue, 6 Nov 2001 09:55:13 -0500
From: Telford002@aol.com
Message-ID: <71.1542b960.29194bf0@aol.com>
Date: Tue, 6 Nov 2001 09:21:36 EST
Subject: Re: How can I know the number of current users in the system?
To: nikberry@med.umich.edu, terje.eggestad@scali.no, amon@vnl.com
CC: weixl@caltech.edu, mlist-linux-kernel@nntp-server.caltech.edu
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: AOL 5.0 for Windows sub 139
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a message dated 11/6/01 8:01:08 AM Eastern Standard Time, 
nikberry@med.umich.edu writes:

> Basically once Unix went beyond serial terminals connected to dumb serial 
> ports, we lost the ability to track users.

I would have phrased the comment somewhat different.

Once Unix adopted the process and file I/O abstraction,
a system wide user count became meaningless.

Unix should be contrasted with Primos or VMS where the
user memory space or program and serial terminal I/O 
are used in defining the multiuser time-sharing capabilities
of the system.

Joachim Martillo
