Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129712AbRBXXo6>; Sat, 24 Feb 2001 18:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129716AbRBXXot>; Sat, 24 Feb 2001 18:44:49 -0500
Received: from [200.222.195.191] ([200.222.195.191]:30082 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S129712AbRBXXok>; Sat, 24 Feb 2001 18:44:40 -0500
Date: Sat, 24 Feb 2001 20:42:53 -0300
From: Frédéric L. W. Meunier <0@pervalidus.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Why CONFIG_MPENTIUMIII by default?
Message-ID: <20010224204253.F127@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.14i
X-Mailer: Mutt/1.3.14i - Linux 2.4.2
X-URL: http://www.pervalidus.net/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any reason to use CONFIG_MPENTIUMIII by default? I
think this should be changed to CONFIG_M386, which should work
for most, and would avoid people reporting problems because
they forgot to set the right processor type.

-- 
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-717-2399 (Niterói-RJ BR)
