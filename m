Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263949AbTEOKbT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 06:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263952AbTEOKbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 06:31:19 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:61329 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S263949AbTEOKbS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 06:31:18 -0400
Message-ID: <20030515104458.4886.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Dean McEwan" <dean_mcewan@linuxmail.org>
To: szepe@pinerecords.com, viro@parcelfarce.linux.theplanet.co.uk
Cc: dean_mcewan@linuxmail.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Date: Thu, 15 May 2003 10:44:58 +0000
Subject: Re: Digital Rights Management - An idea (limited lease, renting,
    expiration, verification) NON HAR*D*WARE BASED.
X-Originating-Ip: 195.195.129.3
X-Originating-Server: ws5-8.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually the program is dynamically encrypted with a new key each time.
Intefering with memory buffers causes the kernel to delete the program, Key is sent over VPN, tampering with the kernel causes
the MD5 hash to be incorrect, and key isn't sent, DRM self scans itself, MD5 hash sums are made on the sources and DRM will
dynamically recompile itself every 32 seconds, checking the sources.
USER key is dynamic, with a different key for every program,
using email to verify said key.
*GASP* for breath :) 
May I note this can make sure GPL is followed as well as proprietary rules...

> > [viro@parcelfarce.linux.theplanet.co.uk]said:
> Two more problems:
> 
> 1)  In this case the decryption key is an intergral part of the software
> and as such needs to be supplied as per fair use clauses.
> 
> 2)  Alan's argument stands.  It is possible to fake the server and provide
> the key once the user have pinched a working copy.  The wrapper can be
> reverse-engineered for communication key magics if need be.
> 
> -- 
> Tomas Szepe <szepe@pinerecords.com>

-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
