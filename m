Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbTE0G5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 02:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbTE0G5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 02:57:54 -0400
Received: from pizda.ninka.net ([216.101.162.242]:53905 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262385AbTE0G5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 02:57:52 -0400
Date: Tue, 27 May 2003 00:10:13 -0700 (PDT)
Message-Id: <20030527.001013.94580735.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: us15@os.inf.tu-dresden.de, jmorris@intercode.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70 (Compiler warnings)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030527.120954.117939073.yoshfuji@linux-ipv6.org>
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com>
	<20030527044519.0014a289.us15@os.inf.tu-dresden.de>
	<20030527.120954.117939073.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Tue, 27 May 2003 12:09:54 +0900 (JST)

   In article <20030527044519.0014a289.us15@os.inf.tu-dresden.de> (at Tue, 27 May 2003 04:45:19 +0200), "Udo A. Steinberg" <us15@os.inf.tu-dresden.de> says:
   
   > crypto/sha512.c:51: warning: integer constant is too large for "long" type
   > crypto/sha512.c:51: warning: integer constant is too large for "long" type
   :
   
   Patch should be simple.
   
Applied, thank you.
