Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbTFFWQR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 18:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTFFWQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 18:16:17 -0400
Received: from jabba.unm.edu ([129.24.9.35]:4003 "HELO jabba.unm.edu")
	by vger.kernel.org with SMTP id S262316AbTFFWQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 18:16:17 -0400
To: linux-kernel@vger.kernel.org, redhat-list@redhat.com
Subject: mkinitrd failed
Date: Fri, 06 Jun 2003 16:29:50 -0600
From: Daniel Sheltraw <sheltraw@unm.edu>
Message-ID: <1054938590.3ee115deead1e@webdjn.unm.edu>
X-Mailer: UNM WebMail v1.1.10 24-January-2003
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: 128.218.13.57
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list

I am rebuilding a 2.4.20 kernel on a RedHat9 system. After doing

make dep
make bzImage
make install

I get an error that mkinitrd has failed. The "RAM disk support" 
and "Init Ram disk" sections of xconfig have been enabled. ANy ideas?

Thanks, DAniel
