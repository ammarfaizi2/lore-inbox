Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUF3WYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUF3WYZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 18:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUF3WYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 18:24:25 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:54178 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263024AbUF3WYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 18:24:24 -0400
Date: Thu, 1 Jul 2004 00:24:01 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Multisession CD incompatibility 2.4 <-> 2.6?
Message-ID: <20040630222400.GA3843@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently got a CD back from a photo lab with Fuji Frontier minilabs.
It had five films scanned and written in one film per session. Linux
2.4.27-mumble shows all the data of the CD right away, Linux 2.6.7
required mount -o session=4 for me to see all directories, without that
option, I'd only see the oldest session.

Has anyone else observed such behaviour?

-- 
Matthias Andree

Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
