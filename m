Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265230AbTAWNu0>; Thu, 23 Jan 2003 08:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265238AbTAWNu0>; Thu, 23 Jan 2003 08:50:26 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:38557 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S265230AbTAWNuZ>; Thu, 23 Jan 2003 08:50:25 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: LKML <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: no version magic, tainting kernel.
Date: Thu, 23 Jan 2003 14:59:22 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301231459.22789.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have writen a small kernel module and it works perfectly, but currently (I 
think it just begun with 2.5.59) I get the warning above when the module is 
inserted. Now I am just interested what I have to change so this message 
won't appear anymore...

Thank you much!

   Thomas Schlichter

P.S.: If my Makefile or source will help I'll give it to you...
