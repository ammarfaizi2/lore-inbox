Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319556AbSH3MU7>; Fri, 30 Aug 2002 08:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319557AbSH3MU6>; Fri, 30 Aug 2002 08:20:58 -0400
Received: from mail.s3.kth.se ([130.237.48.5]:10513 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S319556AbSH3MU5>;
	Fri, 30 Aug 2002 08:20:57 -0400
To: linux-kernel@vger.kernel.org
Subject: Disabling disk cache for single fs
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 30 Aug 2002 14:25:21 +0200
Message-ID: <yw1x7ki8ttxq.fsf@sandwich.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there a way to disable the disk cache for one filesystem?  I don't
want mp3s to waste all the cache that could be used better.

If there isn't a way, what would be a good way to implement it?  As a
mount option?

-- 
Måns Rullgård
mru@users.sf.net
