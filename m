Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289233AbSANN3m>; Mon, 14 Jan 2002 08:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289231AbSANN3W>; Mon, 14 Jan 2002 08:29:22 -0500
Received: from mail006.syd.optusnet.com.au ([203.2.75.230]:953 "EHLO
	mail006.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S289233AbSANN3R>; Mon, 14 Jan 2002 08:29:17 -0500
Subject: Re: slowdown with new scheduler.
From: Antony Suter <antonysuter@optusnet.com.au>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020114124541.A32412@suse.de>
In-Reply-To: <20020114124541.A32412@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 15 Jan 2002 00:27:31 +1100
Message-Id: <1011014852.5220.19.camel@gestalt.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-14 at 23:45, Dave Jones wrote:
> Hi Ingo,
>  After adding H7 to 2.4.18pre3, I noticed that kernel compiles
> on one of my test boxes got much slower.
> Uniprocessor system (Cyrix 3) building a 2.4.18pre3 tree,
> with the same .config, and a distclean before starting the compile.
> 
> 2.4.18pre3        13.38s                       
> 2.4.18pre+H7      17.53s
> 
> I see similar slowdown when running H7 on 2.5 on this box.

Another anecdote: my dnetc client (niced at 19) scores went from 4.2
Mkeys/s to 4.0 Mkeys/s. (Athlon 1.2GHz tbird).

-- 
- Antony Suter  (antonysuter@optusnet.com.au)  "Examiner" 
openpgp:7916EE67
- "Savahnah River. K Reactor. 1968. It was a very good year."

