Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVGVScs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVGVScs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 14:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVGVScr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 14:32:47 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:15080 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262130AbVGVSbS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 14:31:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HmbjdjDe/HRmRYAVBIKVdc/47Q6lHncsQll06Jew+iCZQWKinkkYvRBCo4FKKL7QUJc+UwxT23X1n5eneJKbvE7AFoU6YccC4V1u+hUVkrfnqvoGxOZh7zIrCq1jjo1d3lNQTfCcLhwKICMQqRebieA9LOv7kknfhZX/o4Sn5Ek=
Message-ID: <355e5e5e0507221131666451e3@mail.gmail.com>
Date: Fri, 22 Jul 2005 14:31:18 -0400
From: Lukasz Kosewski <lkosewsk@gmail.com>
Reply-To: Lukasz Kosewski <lkosewsk@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 0/3] Add disk hotswap support to libata
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
In-Reply-To: <42E04D5C.5010907@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42E01024.9030600@nit.ca> <42E04D5C.5010907@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> Pretty cool stuff!
> 
> As soon as I finish SATA ATAPI (this week[end]), I'll take a look at
> this.  A quick review of the patches didn't turn up anything terribly
> objectionable, though :)

Excellent!  Thanks for the quick turnaround!

> P.S.  You might want to CC linux-ide as well, on libata patches. 

I've CCed the original patches to Linux-ide for comments.  Also, I've
re-sent patch 3 with a minor fix to boolean logic with bits.

Enjoy!

Luke Kosewski
Human Cannonball
Net Integration Technologies
