Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWCZVn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWCZVn5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 16:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWCZVn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 16:43:57 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:56802 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S932140AbWCZVn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 16:43:56 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200603262143.k2QLhrDU002007@clem.clem-digital.net>
Subject: 2.6.16-git12 killed networking -- 3c509 card
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Sun, 26 Mar 2006 16:43:53 -0500 (EST)
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:
  Single 3c509 card, UP i386
  Lost networking with .16-git12, message
  ADDRCONF(NETDEV_UP): eth0: link is not ready

  Had several of these with git11
  NETDEV WATCHDOG: eth0: transmit timed out

  No problems observed git1-git10

-- 
Pete Clements 
