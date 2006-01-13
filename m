Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161533AbWAMKRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161533AbWAMKRh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161536AbWAMKRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:17:37 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:25871 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161533AbWAMKRg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:17:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OMS0z26BvUUo1aM06Uuv4T4SLv1toBLY9ESMu4FvHM1j2XMr0MIQ40vfkhEWGGxgAdHIutel6Y3iMCMCSNMnIZstq3Z11cVopM3j8xhN9oOQJ1ZJnseea35/OoSPHP163xvvUW06heRyywEwQvyIT5GRhxu38CuJZ/RCLDE7u+E=
Message-ID: <58cb370e0601130211j50b85af0w3fa2a1a5f872d0e@mail.gmail.com>
Date: Fri, 13 Jan 2006 11:11:14 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: jeff shia <tshxiayu@gmail.com>
Subject: Re: Is there any hard disk standard?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7cd5d4b40601130200m73798389p4939e9e43cb0db87@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7cd5d4b40601130200m73798389p4939e9e43cb0db87@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/06, jeff shia <tshxiayu@gmail.com> wrote:
> Hello,everyone!
>
> Many companies produce hard disks,Is there any hard disk standard?Or
> where can I
> get the standard?

ATA: http://www.t13.org (seems to be down at the moment)
SCSI: http://www.t10.org
SerialATA: http://www.serialata.org

or use www.google.com
