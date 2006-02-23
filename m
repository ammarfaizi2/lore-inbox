Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWBWF1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWBWF1c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 00:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWBWF1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 00:27:32 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:51557 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750820AbWBWF1b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 00:27:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f0Gsid02+E3/O2MhaR1zkhm91YE6utV6Yy/6ccGyNlQ4e1J9ofygkno8nThG8j8hbfZRG5GMRacExPQjcnJ2vG76KXocqZ6K2THGBpms6+amXorcnQUnagjuauireoPpWyh5jbTgV5OYP8NIwnv2/Np7+AqDGx9UwjBHKNnVLT0=
Message-ID: <305c16960602222127v65dadb03q242e69dd1a7f4712@mail.gmail.com>
Date: Thu, 23 Feb 2006 02:27:30 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: cannot open initial console
In-Reply-To: <305c16960602221818h69de46cfpa06027b44c2e07e8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <305c16960602221818h69de46cfpa06027b44c2e07e8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/06, Matheus Izvekov <mizvekov@gmail.com> wrote:
> Hi all
>
> When i tried kernel 2.6.15.4, i noticed i cant boot it, i get
> "warning: cannot open initial console" then it reboots. I've searched
> for it and found the breakage occurs from 2.6.15.1 to 2.6.15.2
>
> Before i start to bisect to find the culpirit, and as there were few
> changes, anyone has a good guess about what broke it?
>
> Thanks all in advance.
>

Actually, i dont even know what git tree i should be using for this...
How can i get the individual patches for the 2.6.15.1 -> 2.6.15.2 transition?
