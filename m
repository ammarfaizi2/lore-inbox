Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVBOXiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVBOXiZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 18:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVBOXhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 18:37:41 -0500
Received: from pat.uio.no ([129.240.130.16]:51870 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261948AbVBOXha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 18:37:30 -0500
Subject: Re: [patch 10/13] Solaris nfsacl workaround
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Olivier Galibert <galibert@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050215230226.GA53551@dspnet.fr.eu.org>
References: <20050122203326.402087000@blunzn.suse.de>
	 <20050122203619.889966000@blunzn.suse.de>
	 <1108488547.10073.39.camel@lade.trondhjem.org>
	 <20050215203553.GA34621@dspnet.fr.eu.org>
	 <1108507404.10073.228.camel@lade.trondhjem.org>
	 <20050215230226.GA53551@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 18:37:19 -0500
Message-Id: <1108510639.21888.33.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.055, required 12,
	autolearn=disabled, AWL 1.95, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 16.02.2005 Klokka 00:02 (+0100) skreiv Olivier Galibert:

> Resolving the problem and/or cleaning the code, no.  Telling what kind
> of patch would be acceptable is your responsability, yes.

Read the patch, read the earlier patch [2/13] in which the same hack
appeared in the client code, and see my response. I'm sure Andreas knows
exactly what was meant by the comment and why.

   Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

