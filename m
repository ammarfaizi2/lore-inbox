Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317436AbSFHU2f>; Sat, 8 Jun 2002 16:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317445AbSFHU2e>; Sat, 8 Jun 2002 16:28:34 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:23699 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S317436AbSFHU2e>; Sat, 8 Jun 2002 16:28:34 -0400
From: David Lang <david.lang@digitalinsight.com>
To: linux-kernel@vger.kernel.org
Date: Sat, 8 Jun 2002 13:24:26 -0700 (PDT)
Subject: Passthrough kernel module?
In-Reply-To: <UTC200206082004.g58K4gV27229.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0206081318430.6927-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am attempting to reverse engineer the interface for a piece of equipment
and it would be extreamly handy to have a kernel module that I could load
that I could then point a /dev entry and and have the module echo
everything that is sent to it (reads/writes/ioctls) to the real device,
recording the request and response.

Does such a module exist? Is there a better way to do this that I'm
missing?

David Lang
