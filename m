Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263554AbTDGQVR (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 12:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263553AbTDGQVR (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 12:21:17 -0400
Received: from smtp03.web.de ([217.72.192.158]:56341 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263554AbTDGQVQ (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 12:21:16 -0400
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: Sergei Organov <osv@javad.ru>
Subject: Re: modifying line state manually on ttyS
Date: Mon, 7 Apr 2003 18:32:30 +0200
User-Agent: KMail/1.5
References: <200304071702.08114.freesoftwaredeveloper@web.de> <87d6jyiany.fsf@osv.javad.ru>
In-Reply-To: <87d6jyiany.fsf@osv.javad.ru>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200304071832.20627.freesoftwaredeveloper@web.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 April 2003 17:34, Sergei Organov wrote:
> Do ioctl(fd, TIOCSBRK, 0) / ioctl(fd, TIOCSBRK, 0) help?

What does it do? I haven't found a description for TIOCSBRK, TIOCSBRK.

Regards
Michael Buesch.

-- 
My homepage: http://www.8ung.at/tuxsoft
fighting for peace is like fu**ing for virginity

