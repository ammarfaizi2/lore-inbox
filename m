Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262823AbVDAR3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbVDAR3O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 12:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbVDAR3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 12:29:13 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:64566 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262823AbVDAR2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 12:28:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Vp5vIkt2+Cm4Zqev7wSfCO/6sMRm9YG0/gkjLidgH69bJpan8DtJdjeLzaRSFoteWv5/bvSz6YTE425cP8ZxHF8NEFdgTn54kjY4iHXtx7aHm9veKmZ1BBGQvCDT8saiyoI9opI7zL0B2BG5/dfr2iMRN+Cp2ln0xFBmoWD/ZEI=
Message-ID: <9e473391050401092846b0d185@mail.gmail.com>
Date: Fri, 1 Apr 2005 12:28:40 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: "Josef E. Galea" <josefeg@euroweb.net.mt>
Subject: Re: Linux virtual memory manager
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <424C09B0.2080502@euroweb.net.mt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <424C09B0.2080502@euroweb.net.mt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 31, 2005 9:31 AM, Josef E. Galea <josefeg@euroweb.net.mt> wrote:
> Hi,
> 
> Can someone point me to a document explaining the differences between
> the 2.4 and the 2.6 virtual memory manager. Particularly I am looking
> for the function/s that replaces the try_to_swap_out() in the 2.6.x
> series of kernels.

There is a large amount of info on the VM here:
http://www.skynet.ie/~mel/projects/vm/

-- 
Jon Smirl
jonsmirl@gmail.com
