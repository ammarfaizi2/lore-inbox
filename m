Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVBTAVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVBTAVq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 19:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVBTAVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 19:21:45 -0500
Received: from agminet04.oracle.com ([141.146.126.231]:1686 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S262330AbVBTAUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 19:20:07 -0500
Date: Sat, 19 Feb 2005 16:20:00 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: updated list of unused kernel exports posted
Message-ID: <20050220002000.GC27331@ca-server1.us.oracle.com>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org
References: <1108847674.6304.158.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108847674.6304.158.camel@laptopd505.fenrus.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bio_map_user
bio_unmap_user

Used by Oracle's GPL ASMLib driver.

dcache_readdir
simple_commit_write
simple_getattr
simple_link
simple_prepare_write
simple_readpage
simple_rename
simple_sync_file

Used By OCFS2.

Joel

-- 

Life's Little Instruction Book #198

	"Feed a stranger's expired parking meter."

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
