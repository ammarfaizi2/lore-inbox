Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272681AbTHKPPJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 11:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272702AbTHKPPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 11:15:09 -0400
Received: from pat.uio.no ([129.240.130.16]:57596 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S272681AbTHKPPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:15:06 -0400
To: Adam Langley <agl@imperialviolet.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: net/sunrpc/auth.c bad pointers in credcache
References: <20030811113258.GA3627@linuxpower.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 11 Aug 2003 08:14:35 -0700
In-Reply-To: <20030811113258.GA3627@linuxpower.org>
Message-ID: <shs8yq0z0o4.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nope. I've never seen that particular error (either in UP or SMP
systems) and nor am I able to see from the code what could be
corrupting that list.

Mind giving some more details on your setup? Please include info on
3rd party patches used, closed source modules used...

Cheers,
  Trond
