Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265010AbTFQXop (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 19:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265012AbTFQXop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 19:44:45 -0400
Received: from aneto.able.es ([212.97.163.22]:32711 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S265010AbTFQXoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 19:44:44 -0400
Date: Wed, 18 Jun 2003 01:58:38 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 timeline was RE: 2.4.21-rc7 ACPI broken
Message-ID: <20030617235838.GA2677@werewolf.able.es>
References: <3EE66C86.8090708@free.fr> <Pine.LNX.4.55L.0306172019550.31986@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.55L.0306172019550.31986@freak.distro.conectiva>; from marcelo@conectiva.com.br on Wed, Jun 18, 2003 at 01:25:22 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.18, Marcelo Tosatti wrote:
> 
> 
> On Wed, 11 Jun 2003, Eric Valette wrote:
> 
> > Marcelo Tosati wrote:
> >
> >  >The main reason I didnt want to merge it was due to its size. Its just
> >  >too big.
> >
> >  >> Please stop leading me along. Will you EVER merge it?
> >
> >  >Yes, I want to, and will merge it. In 2.4.23-pre.
> >
> > This kind of mails and sentence makes you lost your credibility :
> > 	1) You said that ACPI will be merged in 2.4.22-pre,
> > 	2) For many people ACPI (and aic7xxx) is top priority for 2.4 kernel
> > (see various post including alan). The reason being that most laptop are
> > unusable nowadays without ACPI,
> > 	3) You do not explicitely says what you plan for 2.4.22...
> 
> My plan for 2.4.22 is:
> 
>  - Include the new aic7xxx driver.
>  - Include ACPI. (I now realized its importance). Already discussing with
>    Andrew the best way to do it.
>  - Fix the latency/interactivity problems (Chris, Nick and Andrea working
> on that)
>  - Merge obviously correct -aa VM patches.
> 
> Those are the most important things that are needed now, I think.
> 

Would you accept small canges like -march (gcc_check) for x86 ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-1mdk))
