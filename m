Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbVKYLV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbVKYLV0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 06:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVKYLV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 06:21:26 -0500
Received: from fw.archivum.info ([213.41.184.212]:38799 "EHLO
	smtp.trashmail.net") by vger.kernel.org with ESMTP id S1751451AbVKYLVZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 06:21:25 -0500
Date: Fri, 25 Nov 2005 12:21:18 +0100
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Announcing NOOFS 0.8 Release Candidate
Message-ID: <20051125112118.GA18692@archivum.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: mailarch@archivum.info
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The NOOFS development team is proud to announce its new release version 0.8
of its new network file system.

The project is developed within the framework of an end of studies
project in EPITECH. The major goal of this project is to provide a
file system storing its data in an SQL relational database (MySQL,
PostgreSQL, Oracle...). NOOFS is an experimental project which gives
solution to the problems and limitations of the current file system.

In this direction NOOFS allows:

* Sharing data through the network
* Advanced security management
* Quick search thanks to database engine
* Extended information on the file system elements
* Virtual Directories Management: folder with dynamic contents
* Native data integrity management


Changes since version 0.7:

- New FUSE client with enhanced cache support (FUSE >= 2.4.0)
  We recommend to try this new client instead of using the classic kernel
  driver for the moment.

- PostgreSQL 8.0 driver fixed

- Major improvements of MySQL 4.1 driver

- New support of MySQL 5.0

- Major bug fixes in the kernel FS driver for kernel 2.6.x.x

- libxml2 removed: NOOFS no more use the libxml2 to have less packages
  dependencies

- Major bug and security fixes for the whole project


If you are interessted, download the latest source code of NOOFS at:
http://www.noofs.org/

-- 
Best regards,
the NOOFS development team.
E-Mail: contact@noofs.org
