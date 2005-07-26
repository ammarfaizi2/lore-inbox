Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVGZG1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVGZG1S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 02:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVGZG1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 02:27:18 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:22700 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261752AbVGZG1L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 02:27:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hpgWamCX7LbxSytiIxbuw0kjEALwEwebP1jf6Xym5RG7cuRv4Fg2pCqjYHf2HIiqo73UheZ4SMxd5tfcRrv2UP87TeVG5oTtoChnYDcX+MYWN8Qaf3TxgaXw6c29RHzEDsbVGlP2u38N6G1oa0DuK5zEKFIf7+ivhQuMv3BYyH8=
Message-ID: <77dc1b220507252327751501b4@mail.gmail.com>
Date: Tue, 26 Jul 2005 11:57:09 +0530
From: deepak jose <deepakpjose@gmail.com>
Reply-To: deepak jose <deepakpjose@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: problem while executing insmod
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sir/madam,

i written a module function similar to hello, world in C .i compiled
it.but when i ,m loading the module i'm getting the error that "the
kernel compiled is kernel 2.4.20 whereas i'm having 2.4.20-8".
wat i have to do to load it properly without forcing it to load.
did i have to change my kernel.
please suggest me a solution without changing the kernel.
