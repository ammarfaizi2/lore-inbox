Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266209AbUHaRxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266209AbUHaRxF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUHaRxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:53:05 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:52449 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266223AbUHaRvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:51:08 -0400
From: Patrick Dreker <patrick@dreker.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [DOC] Linux kernel patch submission format
Date: Tue, 31 Aug 2004 19:50:59 +0200
User-Agent: KMail/1.7
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Jeremy Higdon <jeremy@sgi.com>
References: <413431F5.9000704@pobox.com>
In-Reply-To: <413431F5.9000704@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408311951.02430.patrick@dreker.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:55d40479e9cc6e4ab087ddd2b9b4bce4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 31. August 2004 10:08 schrieb Jeff Garzik:
> I tried to keep it as short as possible:  here is a page describing the
> most optimal format for sending patches to Linux kernel developers.
>
>  http://linux.yyz.us/patch-format.html
>
> This URL should be permanent, feel free to bookmark it.
> Comments welcome.

Small typo fixed

Patrick

--- patch-format.html.orig 2004-08-31 19:43:33.000000000 +0200
+++ patch-format.html 2004-08-31 19:44:43.000000000 +0200
@@ -51,7 +51,7 @@
 </pre>
 
 The "$n/$total" may be omitted if there is only one patch in the series.
-Writing "1/1" would is not necessary.
+Writing "1/1" is not necessary.
 
 
 <li><h2>Email body contents: description</h2>

-- 
Patrick Dreker

GPG KeyID  : 0xFCC2F7A7 (Patrick Dreker)
Fingerprint: 7A21 FC7F 707A C498 F370  1008 7044 66DA FCC2 F7A7
Key available from keyservers
