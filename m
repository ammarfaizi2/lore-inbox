Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbTEFMi3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 08:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTEFMi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 08:38:29 -0400
Received: from pat.uio.no ([129.240.130.16]:20683 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262707AbTEFMi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 08:38:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16055.44973.106804.436859@charged.uio.no>
Date: Tue, 6 May 2003 14:50:53 +0200
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Shantanu Goel <sgoel01@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc1-ac2 NFS close-to-open question
In-Reply-To: <20030506022813.GB8350@matchmail.com>
References: <20030427151201.27191.qmail@web12802.mail.yahoo.com>
	<shshe8k6ijs.fsf@charged.uio.no>
	<20030506022813.GB8350@matchmail.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Mike Fedyk <mfedyk@matchmail.com> writes:

     > Might that cause this too:

     > May 5 15:32:10 fileserver kernel: lockd: can't encode
     > arguments: 5

No.

     > 2.4.21-rc1-rmap15g is giving the above error, and
     > 2.4.20-rmap15e is not.  I'll leave it on 2.4.20-rmap15e for now
     > and let you know if there are any errors on that one too.

I'm confused. Are the rmap patches making changes to lockd?
I certainly don't see the above errors in standard 2.4.21-rc1.

Cheers,
  Trond
