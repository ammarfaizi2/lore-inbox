Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273746AbRIQWsX>; Mon, 17 Sep 2001 18:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273736AbRIQWsD>; Mon, 17 Sep 2001 18:48:03 -0400
Received: from codepoet.org ([166.70.14.212]:10348 "HELO winder.codepoet.org")
	by vger.kernel.org with SMTP id <S273746AbRIQWr7>;
	Mon, 17 Sep 2001 18:47:59 -0400
Date: Mon, 17 Sep 2001 16:48:24 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Colonel <klink@clouddancer.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/partitions hosed in 2.4.9-ac10
Message-ID: <20010917164824.A27116@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Colonel <klink@clouddancer.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010917151957.A26615@codepoet.org> <9o5pfu$f03$1@ns1.clouddancer.com> <20010917223203.DACE3783EE@mail.clouddancer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010917223203.DACE3783EE@mail.clouddancer.com>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.8-ac10-rmk1-rmk2, Rebel-NetWinder(Intel sa110 rev 3), 262.14 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Sep 17, 2001 at 03:32:03PM -0700, Colonel wrote:
> 
> Works fine here:

But none of your devices have 2048 byte physical sectors, 
which is the case with my MO drives, and that appears to 
be the root of the problem,

 -Erik

--
Erik B. Andersen   email:  andersee@debian.org, formerly of Lineo
--This message was written using 73% post-consumer electrons--
