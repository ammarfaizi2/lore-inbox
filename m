Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVDOUo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVDOUo5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 16:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVDOUo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 16:44:57 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:24990 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261967AbVDOUo4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 16:44:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qCdC6ag7cmfqvhGNjpOadG0bUbrTL/Zg0yO5u35zgu1LczEiD0OmWF1MqDu5vWjYPjMfHmGAX4Eb1dpj7ELzx7fzpJIPGGntOuTzrO1cK4PVvXaJFoY3j95/iGP5cbTxBQ+bpNXjRt13Rd+mYqOYwJJOexnIQvi+eYm3W87/tzo=
Message-ID: <29495f1d0504151344a33ee24@mail.gmail.com>
Date: Fri, 15 Apr 2005 13:44:55 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Kylene Hall <kjhall@us.ibm.com>
Subject: Re: [PATCH] char/tpm: use msleep(), clean-up timers, fix typo
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0504151522210.24192@dyn95395164>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050310004115.GA32583@kroah.com> <1110415321526@kroah.com>
	 <20050311181816.GC2595@us.ibm.com>
	 <Pine.LNX.4.61.0504151522210.24192@dyn95395164>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/05, Kylene Hall <kjhall@us.ibm.com> wrote:
> I have tested this patch and agree that using msleep is the right.  Please
> apply this patch to the tpm driver.  One hunk might fail b/c the
> typo has been fixed already.

Would you like me to respin the patch, Greg? Or is the failed hunk ok?

Thanks,
Nish
