Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbTFCP4s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbTFCP4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:56:48 -0400
Received: from pat.uio.no ([129.240.130.16]:3797 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S265055AbTFCP4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:56:47 -0400
To: Andrew Ryan <genanr@emsphone.com>
Cc: Michael Frank <mflt1@micrologica.com.hk>, linux-kernel@vger.kernel.org
Subject: Re: NFS io errors on transfer from system running 2.4 to system running 2.5
References: <200306031912.53569.mflt1@micrologica.com.hk>
	<20030603144257.GA31734@thumper2.emsphone.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 03 Jun 2003 18:10:01 +0200
In-Reply-To: <20030603144257.GA31734@thumper2.emsphone.com>
Message-ID: <shs7k83p2g6.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Ryan <genanr@emsphone.com> writes:

     > To me, there is something wrong with the changes that went in
     > in 2.4.20pre4, it should work as it does in pre3 and/or other
     > unix OSes such as FreeBSD. We should not have to work around
     > the problem with hard links or using TCP instead of UDP.

Tough. 'soft' is not a priority of mine. It is a broken feature...

Cheers,
  Trond
