Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265960AbTA2OBg>; Wed, 29 Jan 2003 09:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266006AbTA2OBg>; Wed, 29 Jan 2003 09:01:36 -0500
Received: from mail2.webart.de ([195.30.14.11]:11532 "EHLO mail2.webart.de")
	by vger.kernel.org with ESMTP id <S265960AbTA2OBf>;
	Wed, 29 Jan 2003 09:01:35 -0500
Message-ID: <398E93A81CC5D311901600A0C9F292894693A0@cubuss2>
From: Raphael Schmid <Raphael_Schmid@CUBUS.COM>
To: "'Jesse Pollard'" <pollard@admin.navo.hpc.mil>
Cc: linux-kernel@vger.kernel.org
Subject: RE: AW: Bootscreen
Date: Wed, 29 Jan 2003 15:01:40 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Of course, you HAVE to suppress the new line at the end of
> every line - and force a newline at the beginning of every message
> ... or you will only have a blank line.
Why not modify printk, so it just skips \n? *evil grin*
