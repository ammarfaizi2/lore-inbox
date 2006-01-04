Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751790AbWADVbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbWADVbl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWADVbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:31:41 -0500
Received: from zeus2.kernel.org ([204.152.191.36]:26280 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S1751790AbWADVbl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:31:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=X7zQIVoFPvbEL/lX2pbL64FbYtVDcOqPKTZHEZ9q2/M3SEKzd3pxvepMdoCpKX15rTpDryLgopyUxCkQOY66f5qot8fs2Hkc26Fpj9g4aFd7Tz30NWrT74kogawSGK1dUS+Pr6GIdYAu5djLqNabc87xhQadmZWVfjhTQEncZMI=
Message-ID: <728201270601041329r64ee9fb5h3ff015533c762924@mail.gmail.com>
Date: Wed, 4 Jan 2006 15:29:38 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: setrlimit for RLIMIT_RSS not enforced
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am wondering why setrlimit for RLIMIT_RSS is  not enforced? Is 
there any particular reason for not implementing it? Is there any
taker if I implement it & submit patch for it?

Thanks
Ram Gupta
