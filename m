Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132144AbRCYSJD>; Sun, 25 Mar 2001 13:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132143AbRCYSIo>; Sun, 25 Mar 2001 13:08:44 -0500
Received: from tango.SoftHome.net ([204.144.231.49]:22926 "HELO
	tango.SoftHome.net") by vger.kernel.org with SMTP
	id <S132142AbRCYSIc>; Sun, 25 Mar 2001 13:08:32 -0500
Message-ID: <3ABE33FB.181EC9CD@softhome.net>
Date: Sun, 25 Mar 2001 13:07:55 -0500
From: "Todd M. Roy" <toddroy@softhome.net>
Reply-To: toddroy@softhome.net
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: new aic7xxx needs berkeley db?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
  I notice that the new aic7xxx driver needs some version
of the berkekey db.  (the make file has -ldb1 in it).  It blew
up on my because I apparently don't have it installed.  
-- 
  .~.  Todd Roy, Senior Database Administrator  .~.
  /V\     Holstein Association, U.S.A. Inc.     /V\         
 // \\           troy@holstein.com             // \\  
/(   )\         1-802-254-4551x4230           /(   )\
 ^^-^^                                         ^^-^^
