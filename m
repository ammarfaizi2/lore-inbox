Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbTFJQV0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 12:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTFJQV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 12:21:26 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:52595 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S263380AbTFJQVZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 12:21:25 -0400
Message-ID: <3EE60791.8030900@rackable.com>
Date: Tue, 10 Jun 2003 09:30:09 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Reiserfs vs rpm wierdness
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jun 2003 16:35:06.0876 (UTC) FILETIME=[405583C0:01C32F6E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Anytime I try to install an rpm, or even run "rpm -qa"  2.5.70, and RH 
9.   I get the following error.

error: db4 error(22) from dbenv->open: Invalid argument
error: cannot open Packages index using db3 - Invalid argument (22)
error: cannot open Packages database in /var/lib/rpm
no packages


  If I reboot into redhat's 2.4.20-9 rpm works fine.  As far as I can 
tell there doesn't appear to be any file system corruption.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


