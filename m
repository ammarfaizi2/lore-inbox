Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbTBTBEH>; Wed, 19 Feb 2003 20:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbTBTBEH>; Wed, 19 Feb 2003 20:04:07 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:38663 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S262201AbTBTBEF>; Wed, 19 Feb 2003 20:04:05 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302200115.h1K1FVqQ002285@81-2-122-30.bradfords.org.uk>
Subject: [ANNOUNCE] Kernel Bug Database documentation on-line
To: linux-kernel@vger.kernel.org
Date: Thu, 20 Feb 2003 01:15:31 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've put some extensive documentation for the latest version of my
Kernel Bug Database online at:

http://grabjohn.com/kernelbugdatabase/documentation/

The latest version of the Kernel Bug Database is at the usual location:

http://grabjohn.com/kernelbugdatabase/

Main new features since version 2.0:

* A slightly redesigned layout that loads more quickly
* Kernel versions are now sorted numerically by version number order
* The list of all bug reports or confirmed bugs on the search screens
  has been replaced with a list of the five most recent
* Search results now include status information for the latest tested
  kernel versions, not the latest versions. 
* Automatic archiving of bug reports after four weeks
* An active/archive flag for bug reports and confirmed bugs
* A count of the number of returned bug reports, confirmed bugs or
  patches for each search
* A count of the number of non-returned due to being archived bug
  reports or confirmed bugs for each relevant search
* The searching of confirmed bugs page now replaces the initial main menu
* An 'include status information for a particular kernel version'
  toggle in bug reports and confirmed bug search pages

I've written the code for automatic testing of patches to see whether
they will apply to various kernel versions, but it will not be enabled
until the machine that hosts http://grabjohn.com/ is replaced with a
faster one with more disk space :-).

Any comments and suggestions would be appreciated.

John.
