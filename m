Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267126AbTBHXms>; Sat, 8 Feb 2003 18:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267128AbTBHXms>; Sat, 8 Feb 2003 18:42:48 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:47540 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP
	id <S267126AbTBHXmr>; Sat, 8 Feb 2003 18:42:47 -0500
Message-ID: <3E45A7C4.8F1EBDFA@free.fr>
Date: Sun, 09 Feb 2003 01:58:44 +0100
From: Jerome de Vivie <jerome.devivie@free.fr>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mmap inside kernel memory.
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"mmap" seems to be design for mapping file or device inside a process
memory. Is it possible to map a file into the kernel virtual memory ?

kind regards,

j.

-- 
Jérôme de Vivie
