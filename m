Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266957AbSLKCKL>; Tue, 10 Dec 2002 21:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbSLKCKL>; Tue, 10 Dec 2002 21:10:11 -0500
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:25862 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266957AbSLKCKK>; Tue, 10 Dec 2002 21:10:10 -0500
Subject: "bio too big" error
From: Wil Reichert <wilreichert@yahoo.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1039572597.459.82.camel@darwin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 10 Dec 2002 21:17:45 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm getting a "bio too big" error with 2.5.50.  I've got a 330G lvm2
partition formatted with ext3 using the -T largefile4 parameter. 
Everything seems ok at first, but any sort of access will die very
unhappily with said error messsage after about 10 seconds of operation
or so.  The only google search results are the patch submission.  Eeek.

Wil



