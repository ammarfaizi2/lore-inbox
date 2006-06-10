Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWFJKcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWFJKcg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 06:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWFJKcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 06:32:36 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:33382 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751482AbWFJKce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 06:32:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OFY5AS5m+aDRqFUfGBRxT3HSJv9c5MImcFD6vA61xcAkO9lKmO+Jgq6yIc6I1SxIt8yaS2Baeg1RsAEskMMVSrIoUIBh6wHfhLHkgyHtWfHj94oy72q+S7lgw8ylZ+U5jHm1g686Mz1PtMsTXS3aBI6Orni3Wsihr9+GnspBGwg=
Message-ID: <6bffcb0e0606100332t9f305c8ubbc715db7956510e@mail.gmail.com>
Date: Sat, 10 Jun 2006 12:32:33 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc6-rt3
Cc: linux-kernel@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>
In-Reply-To: <20060610082406.GA31985@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060610082406.GA31985@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/06/06, Ingo Molnar <mingo@elte.hu> wrote:
> i have released the 2.6.17-rc6-rt3 tree, which can be downloaded from
> the usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>

My system hangs on boot.

Here is bug http://www.stardust.webpages.pl/files/rt/2.6.17-rc6-rt3/bug1.jpg
Here is config http://www.stardust.webpages.pl/files/rt/2.6.17-rc6-rt3/rt-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
