Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVACFh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVACFh2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 00:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVACFh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 00:37:28 -0500
Received: from web60606.mail.yahoo.com ([216.109.118.244]:19126 "HELO
	web60606.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261386AbVACFhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 00:37:25 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=aiG8djhBLTIKQqVS1NpxtIvodDHGKcmGkUMA37LERL3dy+J7gNKzCSZ9SrBuh0H2MzHPBwv+9fFfH1d9+mBE1ww7KoOQ3UIkt4eWgWzrSuOQwigbnAPP7+H0/mFFP/x1uPcuDmpQ4mqUK9sNNIX3jQ0j299lMke0CQXhq8H4JcU=  ;
Message-ID: <20050103053724.43669.qmail@web60606.mail.yahoo.com>
Date: Sun, 2 Jan 2005 21:37:24 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Getting inode no from current process file descriptor table
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   How can we get the inode number for a file provided
we have the corresponding file descriptor. Can we use
files_struct -> fd[fd] to get struct file ?. From that
how can we get the corresponding inode number?

Regards,
selva


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - now with 250MB free storage. Learn more.
http://info.mail.yahoo.com/mail_250
