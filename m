Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264075AbTFDVPB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 17:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264090AbTFDVPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 17:15:01 -0400
Received: from pat.uio.no ([129.240.130.16]:21132 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264075AbTFDVPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 17:15:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16094.25720.895263.4398@charged.uio.no>
Date: Wed, 4 Jun 2003 23:28:24 +0200
To: Frank Cusack <fcusack@fcusack.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfs_refresh_inode: inode number mismatch
In-Reply-To: <20030604142047.C24603@google.com>
References: <20030603165438.A24791@google.com>
	<shswug2sz5x.fsf@charged.uio.no>
	<20030604142047.C24603@google.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have ques\tions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Frank Cusack <fcusack@fcusack.com> writes:

     > Could you take another look at the specific case I cited?  At
     > the time I try to access the file, the path to it no longer
     > exists.  No information on this file should exist.

I cannot duplicate.

Cheers,
  Trond
