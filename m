Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263735AbUELUmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUELUmq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbUELUka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:40:30 -0400
Received: from mail.broadpark.no ([217.13.4.2]:65513 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S265222AbUELUkJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:40:09 -0400
To: linux-kernel@vger.kernel.org
Subject: Assembler warnings on Alpha
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Date: Wed, 12 May 2004 22:40:08 +0200
Message-ID: <yw1x1xlpv0pj.fsf@kth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When building Linux 2.6.6 on Alpha, I get numerous of these warnings:

{standard input}:6: Warning: setting incorrect section attributes for .got

What's going on?  I'm using gcc 3.3.3 and binutils 2.15.90.  Are these
not good?  Is the resulting kernel safe to boot?

-- 
Måns Rullgård
mru@kth.se
