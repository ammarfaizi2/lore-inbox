Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbTDFN2I (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 09:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbTDFN2I (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 09:28:08 -0400
Received: from smtp01.web.de ([217.72.192.180]:1039 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261693AbTDFN2H (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 09:28:07 -0400
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Subject: Re: Serial port over TCP/IP
Date: Sun, 6 Apr 2003 15:39:00 +0200
User-Agent: KMail/1.5
References: <200304061447.46393.freesoftwaredeveloper@web.de> <20030406131132.GJ639@gallifrey>
In-Reply-To: <20030406131132.GJ639@gallifrey>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304061539.00494.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 April 2003 15:11, Dr. David Alan Gilbert wrote:
> I keep thinking that it would be nice to have a mechanism for user space
> char devices; it would have to have a mechanism to pass all the ioctls
> to the process that dealt with it.

But wouldn't this make too much overhead, if implemented all in userspace?
I say this, because nbd is also implemented in user- und kernel-space.

Regards Michael Buesch. 

-- 
My homepage: http://www.8ung.at/tuxsoft
fighting for peace is like fu**ing for virginity

