Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132852AbRDZTFy>; Thu, 26 Apr 2001 15:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135887AbRDZTFo>; Thu, 26 Apr 2001 15:05:44 -0400
Received: from mx3.port.ru ([194.67.23.37]:51982 "EHLO mx3.port.ru")
	by vger.kernel.org with ESMTP id <S131472AbRDZTF3>;
	Thu, 26 Apr 2001 15:05:29 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Cc: reiser@idiom.com
Subject: ReiserFS question
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.27.16]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E14sr4v-000EC4-00@f3.mail.ru>
Date: Thu, 26 Apr 2001 23:05:25 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

      Hi People...
   got a following "dead of alive" question:
   how to find a root block on a ReiserFS partition
   with a corrupted superblock?

   reiserfsprogs-3.x.0.9j simply writes -2^32
   there at start (reset_super_block) and then simply
   crashes when attempting to access to such mad place
          ... got nearly lost my main partition ...


 sorry for bad english

