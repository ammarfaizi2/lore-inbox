Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287436AbSADQQB>; Fri, 4 Jan 2002 11:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287440AbSADQPu>; Fri, 4 Jan 2002 11:15:50 -0500
Received: from tele-2.inweb.net.uk ([212.38.64.10]:19716 "EHLO
	tele2.inweb.co.uk") by vger.kernel.org with ESMTP
	id <S287436AbSADQPe>; Fri, 4 Jan 2002 11:15:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Steve Wright <stevew@cwazy.co.uk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: /proc/kmsg memory usage ?
Date: Fri, 4 Jan 2002 16:15:24 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02010416152401.00607@box.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am hoping someone here can point me towards the right documentation / web 
page.

I want to find out what happens to kernel messages in /proc/kmsg if they are 
not read.

Specifically, 
Are they cleared after a specified amount of time (eg every 24 hours) ?
Are they cleared when they occupy a maximum size ?
If they are not read will the memory they occupy grow indefinately ?
