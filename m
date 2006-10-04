Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWJDWww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWJDWww (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 18:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWJDWww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 18:52:52 -0400
Received: from mail.gmx.de ([213.165.64.20]:20173 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751206AbWJDWwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 18:52:51 -0400
X-Authenticated: #20450766
Date: Thu, 5 Oct 2006 00:52:39 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Spelling endian*ess
Message-ID: <Pine.LNX.4.60.0610050030370.3843@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am not the only one confused... In a 2.6.18-rc5 tree:

grep -ri "endianness" Documentation/| wc -l
7
grep -ri "endianess" Documentation/| wc -l
5

Which one is correct? Wikipedia has an article about endianness and a 
redirect link for endianess...

Thanks
Guennadi
---
Guennadi Liakhovetski
