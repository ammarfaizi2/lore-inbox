Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318425AbSHENGO>; Mon, 5 Aug 2002 09:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318427AbSHENGO>; Mon, 5 Aug 2002 09:06:14 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:19427 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S318425AbSHENGM>; Mon, 5 Aug 2002 09:06:12 -0400
Date: Mon, 5 Aug 2002 14:07:23 +0100
From: Anthony Campbell <ac@acampbell.org.uk>
To: linux-kernel@vger.kernel.org
Cc: mec@shout.net
Subject: xconfig and menuconfig no longer work -SOLVED
Message-ID: <20020805130723.GC866@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK red-face time. I found that the relevant partition was mounted
read-only. Apologies to anyone who read the original post.

AC



-- 
ac@acampbell.org.uk    ||  http://www.acampbell.org.uk
using Linux GNU/Debian ||  for book reviews, electronic 
Windows-free zone      ||  books and skeptical articles
