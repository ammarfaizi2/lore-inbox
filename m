Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266451AbUFUU1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266451AbUFUU1K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 16:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266457AbUFUU1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 16:27:10 -0400
Received: from web90107.mail.scd.yahoo.com ([66.218.94.78]:59788 "HELO
	web90107.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S266451AbUFUU1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 16:27:03 -0400
Message-ID: <20040621202702.91926.qmail@web90107.mail.scd.yahoo.com>
Date: Mon, 21 Jun 2004 17:27:02 -0300 (ART)
From: =?iso-8859-1?q?so=20usp?= <so_usp@yahoo.com.br>
Subject: returning text from a system call
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm implementing a system call, and I want to return
information (text data) to the user without using the
/var/log/messages (using the printk function). I've
been thinking about writing in a file, but I really
don't know how to manipulate files in kernel mode. The
text could be returned to the command line as well,
but I either don't know how to do that. Does anybody
could help me how to return text (both ways would be
good) from a system call?

Thanks, and sorry for the English.
so_usp 

______________________________________________________________________

Yahoo! Mail - agora com 100MB de espaço, anti-spam e antivírus grátis!
http://br.info.mail.yahoo.com/
