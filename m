Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVECWaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVECWaH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 18:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVECWaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 18:30:06 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:24762 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261869AbVECW3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 18:29:54 -0400
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: LKML <linux-kernel@vger.kernel.org>,
       Ia64 Linux <linux-ia64@vger.kernel.org>
Date: Wed, 4 May 2005 08:29:51 +1000
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Kernel autobuild now uses Git
Message-ID: <20050503222951.GE26031@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All
  Our ia64 autobuild system has been moved from using
BK to Git. Here we do a nightly pull on Linus's 
(not so mainline) Git tree and test the ia64 build.

This may be a benefit to the Git developers to see
the results of a nightly 'cg-pull'.

Thanks to all for the effort, the conversation from BK
to Git was relatively painless.

 - dsw

--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
