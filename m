Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266894AbUGLRj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266894AbUGLRj6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 13:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266895AbUGLRj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 13:39:57 -0400
Received: from web53202.mail.yahoo.com ([206.190.39.218]:20670 "HELO
	web53202.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266894AbUGLRj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 13:39:56 -0400
Message-ID: <20040712173956.55221.qmail@web53202.mail.yahoo.com>
Date: Mon, 12 Jul 2004 14:39:56 -0300 (ART)
From: =?iso-8859-1?q?so=20usp?= <so_usp@yahoo.com.br>
Subject: struct ip_vs_conn
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to use the ip_vs_conn struct inside my
system call, but I don't know how to associate it to
my pointer. I declared a struct ip_vs_conn pointer,
but I don't how to make it points to the structure
inside the kernel. Does anybody know if there are some
function such as "task_struct *get_current()" to
return this kind of data?

Thanks
   


	
	
		
_______________________________________________________
Yahoo! Mail agora com 100MB, anti-spam e antivírus grátis!
http://br.info.mail.yahoo.com/
