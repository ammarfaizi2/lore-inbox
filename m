Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWDWMSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWDWMSj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 08:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWDWMSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 08:18:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13543 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751392AbWDWMSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 08:18:38 -0400
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-time
	authentication of binaries
From: Arjan van de Ven <arjan@infradead.org>
To: Makan Pourzandi <Makan.Pourzandi@ericsson.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Serue Hallyen <serue@us.ibm.com>,
       Axelle Apvrille <axelle_apvrille@rc1.vip.ukl.yahoo.com>,
       "'disec-devel@lists.sourceforge.net'" 
	<disec-devel@lists.sourceforge.net>
In-Reply-To: <4448AC62.6090303@ericsson.com>
References: <4448AC62.6090303@ericsson.com>
Content-Type: text/plain
Date: Sun, 23 Apr 2006 14:18:32 +0200
Message-Id: <1145794712.3131.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 09:56 +0000, Makan Pourzandi wrote:
> Hi,
> 
> Digsig development team would like to announce the release 1.5 of digsig.
> 
> This kernel module helps system administrators control Executable and 
> Linkable Format (ELF) binary execution and library loading based on
> the presence of a valid digital signature.  The main functionality is
> to help system administrators distinguish applications he/she trusts
> (and therefore signs) from viruses, worms (and other nuisances). It is
> based on the Linux Security Module hooks.

does this also prevent people writing their own elf loader in a bit of
perl and just mmap the code ?


