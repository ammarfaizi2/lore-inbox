Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290614AbSA3VSV>; Wed, 30 Jan 2002 16:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290606AbSA3VQY>; Wed, 30 Jan 2002 16:16:24 -0500
Received: from codepoet.org ([166.70.14.212]:18875 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S290611AbSA3VQA>;
	Wed, 30 Jan 2002 16:16:00 -0500
Date: Wed, 30 Jan 2002 14:15:49 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130211549.GB22705@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Jeff Garzik <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020130171126.GA26583@kroah.com> <E16VzZj-00082y-00@the-village.bc.nu> <20020130132939.B29606@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020130132939.B29606@havoc.gtf.org>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jan 30, 2002 at 01:29:39PM -0500, Jeff Garzik wrote:
> I disagree... I outlined a workable scheme for hotplugging SCSI
> controllers to Justin Gibbs a long time ago, when the new aic7xxx was
> first being merged.  Using the new PCI API was fairly easy, handling the
> disk-disappearing-from-under-you problem was a bit more annoying :)

And indeed the aic7xxx driver does handle hotplugging.
It just doesn't handle hot-un-plugging.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
