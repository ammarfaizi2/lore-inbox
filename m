Return-Path: <linux-kernel-owner+w=401wt.eu-S964786AbXAGRwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbXAGRwp (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 12:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbXAGRwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 12:52:45 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:12681 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932622AbXAGRwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 12:52:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I01rKTG/0+owuepSqbPnHHR57REJdlXr+vR8UagNWLttpSdx6a5MbIKJkvRJEGv2jdOriSRfrn45/vYYRJfN+MDK1W/VtIvBdDnVOuqIZv1fBiiCQMC+28uMhvnJSOb1NJ7rDwezdFbEoflgBs0Bs4XWBuO4du0adlUqSorDLCw=
Message-ID: <8355959a0701070952s4f4a3dd9sa0026ce5336b6273@mail.gmail.com>
Date: Sun, 7 Jan 2007 23:22:41 +0530
From: Akula2 <akula2.shark@gmail.com>
To: "Willy Tarreau" <w@1wt.eu>
Subject: Re: Multi kernel tree support on the same distro?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20070107143205.GB435@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8355959a0701041146v40da5d86q55aaa8e5f72ef3c6@mail.gmail.com>
	 <459D9872.8090603@foo-projects.org>
	 <tekrp2tqo78uh6g2pjmrhe0vpup8aalpmg@4ax.com>
	 <20070107093057.GS24090@1wt.eu>
	 <8355959a0701070511v55c671dibc3bb7d4426129e0@mail.gmail.com>
	 <20070107132054.GA435@1wt.eu>
	 <8355959a0701070619w19dd79a5r5ccfdd1121e6a52b@mail.gmail.com>
	 <20070107143205.GB435@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/07, Willy Tarreau <w@1wt.eu> wrote:
> As I already explained in another mail, 2.4.34 builds with gcc-4.1 on x86
> and a few other archs. I also explained how to do this :
>
> $ make CC=gcc-4.1
>
> I don't know how I can explain it to you an easier way, but what I'm sure
> about is that if you are having such big trouble understanding simple
> commands like this, you will certainly encounter many more when building
> your own distro.

I have understood that, it seems I have confused (and myself too) with
my doubts on gcc/kernel versions (getting into details).

> > Whole idea is to have 2 compilers (gcc-3.4.x, gcc-4.1.x) on the both
> > the kernels.
>
> That's what I understood and the need I replied too the first time.

Thanks a lots for your inputs. I shall post more questions once I
progress with this experimental work :-)

> Willy

~Akula2
