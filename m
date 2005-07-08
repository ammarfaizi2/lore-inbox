Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbVGHOiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbVGHOiQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 10:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbVGHOiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 10:38:15 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:33178 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S262676AbVGHOiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 10:38:09 -0400
Message-ID: <42CE8FD2.606@hotmail.com>
Date: Fri, 08 Jul 2005 07:38:10 -0700
From: walt <wa1ter@hotmail.com>
Organization: none
User-Agent: Mail/News Client 1.0+ (X11/20050708)
MIME-Version: 1.0
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: GIT tree broken? (rsync depreciated)
References: <fa.h62oivg.r7ariq@ifi.uio.no> <fa.lbn9c09.1m18e9l@ifi.uio.no>
In-Reply-To: <fa.lbn9c09.1m18e9l@ifi.uio.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:

> After resyncing cogito to the latest version (which incorporates the
> 'pack' changes, which were causing the failure), it does indeed work
> again, when using rsync.

I also found that using cogito-0.12 in my existing source directory
would not update properly.  After some fiddling I gave up and did
a fresh cg-clone which seems to be okay.
