Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbTDVQcO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 12:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263296AbTDVQcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 12:32:14 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:51470 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263290AbTDVQcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 12:32:13 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Julien Oster <frodo@dereference.de>
Subject: Re: kernel ring buffer accessible by users
Date: Tue, 22 Apr 2003 18:44:05 +0200
User-Agent: KMail/1.5
References: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org>
In-Reply-To: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304221844.05754.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 April 2003 18:21, Julien Oster wrote:
> it's been quite a while that I noticed that any ordinary user, not
> just root, can type "dmesg" to see the kernel ring buffer.

just make
$ chmod 700 /bin/dmesg

-- 
Regards Michael Buesch.
http://www.8ung.at/tuxsoft

$ cat /dev/zero > /dev/null
/dev/null: That's *not* funny! :(

