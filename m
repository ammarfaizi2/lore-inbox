Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264808AbUHJNqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264808AbUHJNqP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 09:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUHJNoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 09:44:46 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:14045 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S264973AbUHJNm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 09:42:58 -0400
X-Sender-Authentication: net64
Date: Tue, 10 Aug 2004 15:42:54 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: diablod3@gmail.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       dwmw2@infradead.org, eric@lammerts.org, james.bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-Id: <20040810154254.05e36691.skraw@ithnet.com>
In-Reply-To: <200408101033.i7AAXGpQ012090@burner.fokus.fraunhofer.de>
References: <200408101033.i7AAXGpQ012090@burner.fokus.fraunhofer.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004 12:33:16 +0200 (CEST)
Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:

> 
> >From: Patrick McFarland <diablod3@gmail.com>
> 
> >On Mon, 9 Aug 2004 16:40:52 +0200 (CEST), Joerg Schilling
> ><schilling@fokus.fraunhofer.de> wrote:
> >> People who use the official cdrecord know that they need to run cdrecord
> >> with root privilleges. People who run the bastardized version from SuSE
> >> don't know this and fail to write CDs.
> 
> >This is why people should be using Debian to begin with. Debian asks
> >if you want to install cdrecord with suid so everyone can burn cds
> >without needing to be root first.
> 
> Indeed! Altough minor things could be better with Debian too, Debian is the
> only true Open Source Linux distribution. Other distributions modify programs
> without reason and do not cooperate with the original authors :-(

Would you mind to stop your general accusations against "other distributions"
and your talking for people (i.e. authors) that you don't know or haven't
talked to in your whole lifetime.

Fortunately everybody can decide for himself what distro he likes best. And if
someone thinks he has to modify the original GPL source, then he should do.
If you don't like that, don't use GPL, because the right to modify foreign
sources is a major part of it.

Regards,
Stephan
