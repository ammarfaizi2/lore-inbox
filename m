Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265716AbTIJUFp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 16:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265717AbTIJUFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 16:05:45 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:40057 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S265716AbTIJUFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 16:05:38 -0400
Date: Wed, 10 Sep 2003 16:05:28 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Luca Veraldi <luca.veraldi@katamail.com>
cc: Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Efficient IPC mechanism on Linux
In-Reply-To: <01f801c37783$9ead8960$5aaf7450@wssupremo>
Message-ID: <Pine.LNX.4.44.0309101540270.27932-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003, Luca Veraldi wrote:

> I'm not responsible for microarchitecture designer stupidity.
> If a simple STORE assembler instruction will eat up 4000 clock cycles,
> as you say here, well,

If current trends continue, a L2 cache miss will be
taking 5000 cycles in 15 to 20 years.

> I think all we Computer Scientists can go home and give it up now.

While I have seen some evidence of computer scientists
going home and ignoring the problems presented to them
by current hardware constraints, I'd really prefer it
if they took up the challenge and did the research on
how we should deal with hardware in the future.

In fact, I've made up a little (incomplete) list of
things that I suspect are in need of serious CS research,
because otherwise both OS theory and practice will be
unable to deal with the hardware of the next decade.

	http://surriel.com/research_wanted/

If you have any suggestions for the list, please let
me know.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

