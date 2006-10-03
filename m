Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWJCQtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWJCQtM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 12:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWJCQtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 12:49:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8111 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932319AbWJCQtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 12:49:10 -0400
Date: Tue, 3 Oct 2006 12:49:05 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: FSX on NFS blew up.
Message-ID: <20061003164905.GD23492@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Took ~8hrs to hit this on an NFSv3 mount. (2.6.18+Jan Kara's jbd patch)

http://www.codemonkey.org.uk/junk/fsx-nfs.txt

	Dave

-- 
http://www.codemonkey.org.uk
