Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbULGPud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbULGPud (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 10:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbULGPuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 10:50:32 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:51841 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261828AbULGPu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 10:50:28 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: what does __foo means.
To: krishna <krishna.c@globaledgesoft.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@nurfuerspam.de
Date: Tue, 07 Dec 2004 16:52:33 +0100
References: <fa.gd7ov5r.1n64a8t@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1Cbhdi-00085C-00@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

krishna wrote:

> Hi all,
>  
>     Can anyone tell me does double underscore before a function mean?
>     In which scenario a programmer must use it.

---http://www.mozilla.org/hacking/portable-cpp.html---
According to the C++ Standard, 17.4.3.1.2 Global Names [lib.global.names],
paragraph 1: 

Certain sets of names and function signatures are always reserved to the
implementation: 
Each name that contains a double underscore (__) or begins with an
underscore followed by an uppercase letter (2.11) is reserved to the
implemenation for any use. 
Each name that begins with an underscore is reserved to the implementation
for use as a name in the global namespace.
---

