Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbUBWFxe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 00:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbUBWFxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 00:53:34 -0500
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:64702 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S261825AbUBWFxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 00:53:30 -0500
X-OB-Received: from unknown (205.158.62.133)
  by wfilter.us4.outblaze.com; 23 Feb 2004 05:53:07 -0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Gordon Stanton" <coder101@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Mon, 23 Feb 2004 13:53:28 +0800
Subject: large built-in.o
X-Originating-Ip: 203.2.128.124
X-Originating-Server: ws5-3.us4.outblaze.com
Message-Id: <20040223055328.D70BB23947@ws5-3.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Just a quick question. I was building 2.6.3 with allyesconfig and I noticed it was making many built-in.o files around the place. These are quite large object files
Eg. in fs is 
74992735 Feb 23 15:35 built-in.o
  74Meg for the filesystems code and thats with even the individual .o files compiled with -Os

  I haven't noticed this happening before. Is it new for 2.6.x?


Thanks, Gordon
-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.


Powered by Outblaze
