Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288083AbSAMUcG>; Sun, 13 Jan 2002 15:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288116AbSAMUb4>; Sun, 13 Jan 2002 15:31:56 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:62746 "EHLO
	tsmtp6.mail.isp") by vger.kernel.org with ESMTP id <S288083AbSAMUbo>;
	Sun, 13 Jan 2002 15:31:44 -0500
Date: Sun, 13 Jan 2002 21:35:29 +0100
From: Diego Calleja <grundig@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: __alloc_pages: 0-order allocation failed on 2.4.18-pre2aa2
Reply-To: grundig@teleline.es
X-Mailer: Spruce 0.7.4 for X11 w/smtpio 0.8.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20020113203146Z288083-13996+5124@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this message one time from kernel. I was only running 'apt-get
install XXXX'. No reproducible. Using 2.4.18-pre2aa2:
 
__alloc_pages: 0-order allocation failed (gfp=0xf0/0)

Diego Calleja.
