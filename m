Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136531AbRD3WuW>; Mon, 30 Apr 2001 18:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136538AbRD3WuM>; Mon, 30 Apr 2001 18:50:12 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:50697 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S136531AbRD3Wt5>;
	Mon, 30 Apr 2001 18:49:57 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] [PATCH] automatic multi-part link rules (fwd) 
In-Reply-To: Your message of "Tue, 01 May 2001 00:43:42 +0200."
             <Pine.LNX.4.33.0105010022020.24511-100000@vaio> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 01 May 2001 08:49:49 +1000
Message-ID: <16302.988670989@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2001 00:43:42 +0200 (CEST), 
Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:
>I sent this to the kbuild list about a week ago, and I received exactly
>zero replies, so I'm posting to l-k now. This may mean that the idea is
>totally stupid (but I'd like to know) or unquestionably good (that's what
>I'd prefer :), well, maybe I'll get some feedback this time.

The patch appears to work but is it worth applying now?  The existing
2.4 rules work fine and the entire kbuild system will be rewritten for
2.5, including the case you identified here.  It struck me as a decent
change but for no benefit and, given that the 2.4 kbuild system is so
fragile, why not live with something we know works until 2.5 is
available?

