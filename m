Return-Path: <linux-kernel-owner+w=401wt.eu-S932642AbXAJBzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbXAJBzT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 20:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbXAJBzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 20:55:19 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:39371 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932642AbXAJBzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 20:55:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=EcBQxP0YUw61MCd03aNOhzAo6D4IdbyDAmQkeeKd/YkbouTccUz7CQmPrQm8Vv3qPivwkJ4QDgfNc3FCyHwOyYEXn+0dBu2slZXjgA9o2JKGqSqasqnRvOoFGPGn6gNGLCVQq1PFDHfX9s7hUnk/LWhQd59leCUs31m3HIN8zT8=
Message-ID: <45A4477E.6050703@gmail.com>
Date: Wed, 10 Jan 2007 10:55:10 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Pablo Sebastian Greco <lkml@fliagreco.com.ar>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA problems
References: <459A674B.3060304@fliagreco.com.ar> <459B9F91.9070908@gmail.com> <459BC703.9000207@fliagreco.com.ar> <459C8A5E.5010206@gmail.com> <459CFE7B.6090306@fliagreco.com.ar> <459DC2EE.1090307@fliagreco.com.ar> <45A1AB3F.1080408@gmail.com> <45A2376D.5060905@fliagreco.com.ar> <45A41E0E.9050608@fliagreco.com.ar>
In-Reply-To: <45A41E0E.9050608@fliagreco.com.ar>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Pablo.

Please apply common hardware debugging method.  You know, swap drives.
Use separate power supply for disks, swap cables, etc...

It seems more like a hardware problem at this point.

Thanks.

-- 
tejun
