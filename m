Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285194AbRLFVSn>; Thu, 6 Dec 2001 16:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285191AbRLFVSd>; Thu, 6 Dec 2001 16:18:33 -0500
Received: from tomts10.bellnexxia.net ([209.226.175.54]:23483 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S284248AbRLFVSW>; Thu, 6 Dec 2001 16:18:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Nav Mundi <nmundi@karthika.com>
To: linux-kernel@vger.kernel.org
Subject: 'fd' file descriptor help
Date: Thu, 6 Dec 2001 16:18:05 -0500
X-Mailer: KMail [version 1.3.2]
Cc: apiggyjj@yahoo.ca
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011206211817.FAUB17034.tomts10-srv.bellnexxia.net@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know what the file descriptor 'fd' pointer does?  My module makes 
a system call [sys_open] to the kernal which then returns a fd value but I 
don't know what this value means or how it gets it.  Does the fd value 
signify a specific device or is it random?  Any ideas?

Thanks for your help in advance.

-Nav
