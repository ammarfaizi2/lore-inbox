Return-Path: <linux-kernel-owner+w=401wt.eu-S964899AbXASWau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbXASWau (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 17:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbXASWau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 17:30:50 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:32290 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964899AbXASWat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 17:30:49 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DmBi5Qet4XlvZWXpLiUju2tz5NdrPUJH9T+Ms6JkV0YuaaogwHGSGm8ecL4H+amFMXzhx0ZHZSxbhQQwDlgr1sBsdmcen3H6PMW+PsCJKur63FS1UirTQtK/1P5+fg46upJmsDLFG4DV0tzmpVatd01iX9XDsaFe8jJOBzQoXRE=
Message-ID: <7b69d1470701191430p5e7df345k82f8ad0cd984734a@mail.gmail.com>
Date: Fri, 19 Jan 2007 16:30:47 -0600
From: "Scott Preece" <sepreece@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: [ANNOUNCE] System Inactivity Monitor v1.0
Cc: "Alessandro Di Marco" <dmr@gmx.it>,
       "Arjan van de Ven" <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0701192320520.18606@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <877ivkrv5s.fsf@gmx.it>
	 <1169192306.3055.379.camel@laptopd505.fenrus.org>
	 <87zm8fkr5k.fsf@gmx.it>
	 <7b69d1470701190945w2da4e4ffqd8bca21a6d1d80d0@mail.gmail.com>
	 <Pine.LNX.4.61.0701192320520.18606@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/07, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> On Jan 19 2007 11:45, Scott Preece wrote:
> > Hi, attached is a patch for your gentable file, rewriting some of the
> > user prompts to make them more readable.
>
> I still don't get why this is called "SIN" in the Kconfig and code texts
> though the acronym for System Inactivity Monitor would be "SIM".
---

The code calls it "System Inactivity Notifier".

scott
