Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271802AbRH1QSX>; Tue, 28 Aug 2001 12:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271806AbRH1QSD>; Tue, 28 Aug 2001 12:18:03 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:29703 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S271802AbRH1QR7>;
	Tue, 28 Aug 2001 12:17:59 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200108281618.f7SGICk265931@saturn.cs.uml.edu>
Subject: Re: How to create a patch ?
To: pallaire@gameloft.com (Patrick Allaire)
Date: Tue, 28 Aug 2001 12:18:12 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <9A1957CB9FC45A4FA6F35961093ABB8404220590@srvmail-mtl.ubisoft.qc.ca> from "Patrick Allaire" at Aug 28, 2001 08:26:52 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Allaire writes:

> What is the correct way to create a patch for the kernel ? I meen ... what
> option should I pass to diff ?

diff -Naurd old-kernel-dir new-kernel-dir
