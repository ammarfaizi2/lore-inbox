Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272620AbRI3GVu>; Sun, 30 Sep 2001 02:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272636AbRI3GVj>; Sun, 30 Sep 2001 02:21:39 -0400
Received: from [63.193.79.18] ([63.193.79.18]:41967 "HELO mwg.inxservices.lan")
	by vger.kernel.org with SMTP id <S272620AbRI3GVc>;
	Sun, 30 Sep 2001 02:21:32 -0400
Date: Sat, 29 Sep 2001 23:21:27 -0700
From: George Garvey <tmwg-linuxknl@inxservices.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac10 IDE access slows as uptime increases
Message-ID: <20010929232127.A949@inxservices.com>
In-Reply-To: <20010928204612.A911@inxservices.com> <E15nLB7-00027t-00@the-village.bc.nu> <20010929085323.A31121@inxservices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010929085323.A31121@inxservices.com>; from tmwg@inxservices.com on Sat, Sep 29, 2001 at 08:53:23AM -0700
Organization: inX Services, Los Angeles, CA, USA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2001 at 08:53:23AM -0700, Phil Blecker wrote:
>    I'm going to try removing the IDE to SCSI stuff that I installed to
> try and get a USB CDRW drive working.

   That seems to have worked. Haven't used the system as heavily today
as usual, but the slowdown didn't happen. Makes no sense to me, but what
do I know?
