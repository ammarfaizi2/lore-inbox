Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVBBGNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVBBGNE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 01:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVBBGND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 01:13:03 -0500
Received: from mxc.rambler.ru ([81.19.66.31]:35590 "EHLO mxc.rambler.ru")
	by vger.kernel.org with ESMTP id S262042AbVBBGM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 01:12:56 -0500
Date: Wed, 2 Feb 2005 09:10:12 -0500
From: Pavel Fedin <sonic_amiga@rambler.ru>
To: linux-kernel@vger.kernel.org
Subject: Generating NLS modules
Message-Id: <20050202091012.3274b5f2.sonic_amiga@rambler.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Auth-User: sonic_amiga, whoson: (null)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Nobody answered so i repeat the question.
 I think i found a way to make use of NLS table for HFS filesystem and
i'm going to try to implement it. But first i need to create NLS module
for codepage 10007 (Mac cyrillic). In the beginning of every existing
NLS module code i see comment which says that this file is automatically
generated from data found at unicode.org. Could you tell me where i can find a
convertor and what data it can use as unput? I explored unicode.org and found
some conversion data at oss.software.ibm.com/icu/. The data is available in
UCM and XML formats. Are those files suitable?

-- 
Best regards,
Pavel Fedin,									mailto:sonic_amiga@rambler.ru
