Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266434AbTBTRno>; Thu, 20 Feb 2003 12:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266535AbTBTRnn>; Thu, 20 Feb 2003 12:43:43 -0500
Received: from cambot.suite224.net ([209.176.64.2]:13583 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S266434AbTBTRnh>;
	Thu, 20 Feb 2003 12:43:37 -0500
Message-ID: <000701c2d909$04669540$0100a8c0@pcs686>
From: "Matthew D. Pitts" <mpitts@suite224.net>
To: <linux-kernel@vger.kernel.org>
Subject: Modules Debate
Date: Thu, 20 Feb 2003 12:53:46 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fellow kernel hackers,

I think that we have missed the point that Rusty has been trying to make.
The existing modutils have to support multiple interfaces and as he has said
in the past, some of those interfaces are difficult, if not impossible to
use as the authors intended. He is trying to get all coders on the same page
with his new module interface, and it is normal that some are upset with his
decision to change things. But Linus seems to understand where Rusty is
trying to take the development effort and has chosen to go with Rusty's
ideas. Those that don't want to change are free, as always, to make their
code available to those that wish to use it. Rusty, correct me if I'm wrong,
but wasn't the gist of what you said at the Kernel Summit last summer that
we should build in as much as we knew we needed to support our hardware and
use modules for stuff we weren't going to use as often?

Matthew D. Pitts

