Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbTAJMYP>; Fri, 10 Jan 2003 07:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbTAJMYP>; Fri, 10 Jan 2003 07:24:15 -0500
Received: from mail.sevencubes.de ([62.245.134.131]:61063 "HELO
	wwwserver1.sevencubes.de") by vger.kernel.org with SMTP
	id <S264938AbTAJMYM> convert rfc822-to-8bit; Fri, 10 Jan 2003 07:24:12 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Robert Szentmihalyi <robert.szentmihalyi@entracom.de>
Organization: Entracom GmbH
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Severe reiserfs problems
Date: Fri, 10 Jan 2003 13:32:50 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301101332.50873.robert.szentmihalyi@entracom.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
I have severe file system problems on a reiserfs partition.
When I try copy files to another filesystem, the kernel panics at certain 
files.

reiserfsck --fix-fixable says that I need to run 
reiserfsck --rebuild-tree to fix the errors, but when I do this,
reiserfsck hangs after a few secounds.
Is there a way to rescue at least some of the data on the partition?

Any help is highly appreciated.

TIA,
 Robert


-- 
Where do you want to be tomorrow?

Entracom. Building Linux systems.
http://www.entracom.de

