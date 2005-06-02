Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVFBAEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVFBAEm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 20:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVFBABQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 20:01:16 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:22276 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261499AbVFBAAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 20:00:08 -0400
Date: Wed, 1 Jun 2005 17:03:47 -0700
To: Bill Huey <bhuey@lnxw.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Ingo Molnar <mingo@elte.hu>,
       Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050602000347.GA12918@nietzsche.lynx.com>
References: <20050601195905.GX5413@g5.random> <20050601201754.GA27795@nietzsche.lynx.com> <20050601203212.GZ5413@g5.random> <20050601204612.GA27934@nietzsche.lynx.com> <20050601210716.GB5413@g5.random> <20050601214257.GA28196@nietzsche.lynx.com> <20050601215913.GB28196@nietzsche.lynx.com> <20050601223250.GH5413@g5.random> <20050601230244.GA11262@nietzsche.lynx.com> <20050601235932.GA12613@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601235932.GA12613@nietzsche.lynx.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 04:59:32PM -0700, Bill Huey wrote:
> They still all have to interact with each other in a temporarly protected
> way so that latency is propagated through each RT domain (soft, hard, none)
> in the app.

Sorry, is "not" propagated through those domains by accident.

bill

