Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWE1I15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWE1I15 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 04:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWE1I15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 04:27:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22977 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751287AbWE1I14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 04:27:56 -0400
Subject: Re: How to check if kernel sources are installed on a system?
From: Arjan van de Ven <arjan@infradead.org>
To: bidulock@openss7.org
Cc: Lee Revell <rlrevell@joe-job.com>, devmazumdar <dev@opensound.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060527162118.E15216@openss7.org>
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe>
	 <1148653797.3579.18.camel@laptopd505.fenrus.org>
	 <20060526093530.A20928@openss7.org>
	 <1148732512.3265.0.camel@laptopd505.fenrus.org>
	 <20060527135214.A15216@openss7.org>
	 <1148761299.3265.241.camel@laptopd505.fenrus.org>
	 <20060527162118.E15216@openss7.org>
Content-Type: text/plain
Date: Sun, 28 May 2006 10:27:51 +0200
Message-Id: <1148804871.3074.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But not the right place for the running kernel.  /boot/config-`uname -r` will
> be of the wrong architecture for the running kernel.

so yes you can use --force to cause it to overwrite a file. DUH.
Big yawn as will since this file isn't needed for anything but for a
human to build his own kernel; if that human first does the really silly
--force thing (which is a great way to hose your system) then he knows
there might not be an exact match. Big Yawn(tm) :)


