Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRALG2E>; Fri, 12 Jan 2001 01:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbRALG1y>; Fri, 12 Jan 2001 01:27:54 -0500
Received: from austin.jhcloos.com ([206.224.83.202]:41738 "HELO
	austin.jhcloos.com") by vger.kernel.org with SMTP
	id <S129183AbRALG1r>; Fri, 12 Jan 2001 01:27:47 -0500
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: named streams, extended attributes, and posix
In-Reply-To: <3A5E10F5.716F83B7@holly-springs.nc.us>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <3A5E10F5.716F83B7@holly-springs.nc.us>
Date: 12 Jan 2001 00:27:46 -0600
Message-ID: <m3snmpgu8t.fsf@austin.jhcloos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael> Please read and comment! :)

There should be some discussion on what to do about filenames which
contain colons in such a setup.  Moving a file w/ a colon from a fs
which does not support named streams to one which does should DTRT;
exactly what TRT is should be discussed.

-JimC
-- 
James H. Cloos, Jr.  <http://jhcloos.com/public_key>     1024D/ED7DAEA6 
<cloos@jhcloos.com>  E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
