Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263259AbTKQBYY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 20:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbTKQBYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 20:24:23 -0500
Received: from pat.uio.no ([129.240.130.16]:60293 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263259AbTKQBYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 20:24:23 -0500
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Lista Linux-BProc <bproc-users@lists.sourceforge.net>
Subject: Re: Reading libs fails through NFS
References: <20031117004539.GA2155@werewolf.able.es>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 16 Nov 2003 20:24:18 -0500
In-Reply-To: <20031117004539.GA2155@werewolf.able.es>
Message-ID: <shsu153okhp.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == J A Magallon <J.A.> writes:

     > Hi all...  Anybody has any idea about why this fails:

     >     fd = open("/lib/libnss_files.so.2", O_RDONLY); res =
     >     read(fd,buf,512);

No. Nobody else will be able to tell you either until you tell us what
setup you are using.

Cheers,
  Trond
