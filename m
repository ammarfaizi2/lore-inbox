Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266842AbTAOSch>; Wed, 15 Jan 2003 13:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266844AbTAOScg>; Wed, 15 Jan 2003 13:32:36 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:64973 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S266842AbTAOScg>; Wed, 15 Jan 2003 13:32:36 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: linux-kernel@vger.kernel.org
Subject: problem using integer division in kernel modules
Date: Wed, 15 Jan 2003 19:41:29 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301151941.29690.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am writing at a small kernel module and have a problem now using / and %. If 
I do so I get following unresolved symbols when the module should be loaded:
  __divdi3
  __moddi3

Could you please help me and tell me what I do wrong..?
