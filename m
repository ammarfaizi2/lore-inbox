Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264418AbTKMUfq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 15:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264421AbTKMUfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 15:35:46 -0500
Received: from pat.uio.no ([129.240.130.16]:8843 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264418AbTKMUfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 15:35:45 -0500
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Martin.Knoblauch@mscsoftware.com, root@chaos.analogic.com,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs_statfs: statfs error = 116
References: <OF8497F0B5.C94E6443-ONC1256DDD.0051048E-C1256DDD.0051C1A9@mscsoftware.com>
	<03111314262500.15082@tabby>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 13 Nov 2003 15:34:55 -0500
In-Reply-To: <03111314262500.15082@tabby>
Message-ID: <shsislof1n4.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jesse Pollard <jesse@cats-chateau.net> writes:

     > ESTALE should occur whenever the client looses connection to
     > the server, or thinks it has lost connection.

No it should not.

Cheers,
  Trond
