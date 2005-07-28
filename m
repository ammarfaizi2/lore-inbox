Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVG1MjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVG1MjQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 08:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVG1MjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 08:39:16 -0400
Received: from khc.piap.pl ([195.187.100.11]:7428 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S261433AbVG1MjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 08:39:15 -0400
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Raise required gcc version to 3.2 ?
References: <20050728120012.GB3528@stusta.de>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 28 Jul 2005 14:39:12 +0200
In-Reply-To: <20050728120012.GB3528@stusta.de> (Adrian Bunk's message of
 "Thu, 28 Jul 2005 14:00:12 +0200")
Message-ID: <m3hdefxfyn.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> Is there any good reason why we should not drop support for older 
> compilers?

Compilation speed? Don't know, using 3 (4?) years old Athlon 2000
it's not a problem unless I need full build 30 times a day.

But people on 266 MHz ARM5 may notice.
-- 
Krzysztof Halasa
