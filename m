Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267491AbSLRXZ0>; Wed, 18 Dec 2002 18:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267487AbSLRXYt>; Wed, 18 Dec 2002 18:24:49 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:48913 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267470AbSLRXXn>;
	Wed, 18 Dec 2002 18:23:43 -0500
Date: Wed, 18 Dec 2002 15:29:01 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] LSM changes for 2.5.52
Message-ID: <20021218232900.GE1782@kroah.com>
References: <20021218231917.GA1782@kroah.com> <20021218232125.GB1782@kroah.com> <20021218232714.GC1782@kroah.com> <20021218232810.GD1782@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021218232810.GD1782@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.901, 2002/12/18 15:10:25-08:00, greg@kroah.com

LSM: update the copyright dates for my entry.


diff -Nru a/security/dummy.c b/security/dummy.c
--- a/security/dummy.c	Wed Dec 18 15:13:29 2002
+++ b/security/dummy.c	Wed Dec 18 15:13:29 2002
@@ -3,7 +3,7 @@
  * security model is loaded.
  *
  * Copyright (C) 2001 WireX Communications, Inc <chris@wirex.com>
- * Copyright (C) 2001 Greg Kroah-Hartman <greg@kroah.com>
+ * Copyright (C) 2001-2002  Greg Kroah-Hartman <greg@kroah.com>
  * Copyright (C) 2001 Networks Associates Technology, Inc <ssmalley@nai.com>
  *
  *	This program is free software; you can redistribute it and/or modify
diff -Nru a/security/security.c b/security/security.c
--- a/security/security.c	Wed Dec 18 15:13:29 2002
+++ b/security/security.c	Wed Dec 18 15:13:29 2002
@@ -2,7 +2,7 @@
  * Security plug functions
  *
  * Copyright (C) 2001 WireX Communications, Inc <chris@wirex.com>
- * Copyright (C) 2001 Greg Kroah-Hartman <greg@kroah.com>
+ * Copyright (C) 2001-2002 Greg Kroah-Hartman <greg@kroah.com>
  * Copyright (C) 2001 Networks Associates Technology, Inc <ssmalley@nai.com>
  *
  *	This program is free software; you can redistribute it and/or modify
