Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265119AbUD3PMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265119AbUD3PMc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 11:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbUD3PMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 11:12:32 -0400
Received: from userel174.dsl.pipex.com ([62.188.199.174]:48774 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S265119AbUD3PMb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 11:12:31 -0400
Date: Fri, 30 Apr 2004 16:06:33 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@einstein.homenet
To: Jeff Garzik <jgarzik@pobox.com>
cc: Marc Boucher <marc@linuxant.com>, Sean Estabrooks <seanlkml@rogers.com>,
       <koke@sindominio.net>, <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>, <riel@redhat.com>,
       <david@gibson.dropbear.id.au>, <torvalds@osdl.org>,
       <miller@techsource.com>, <paul@wagland.net>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <40920881.6070300@pobox.com>
Message-ID: <Pine.LNX.4.44.0404301557230.4027-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2004, Jeff Garzik wrote:
> DriverLoader significantly lowers that cost, while not providing an open 
> source solution at all.

Ah, I see.... that makes a HUGE difference. Now I understand what the fuss
is all about. So, that is why everyone jumped on Marc Boucher's throat
trying to annihilate, humiliate, frighten by unsubstantiated allegations
and generally grind him into tiny specks of dust, at the same time falsely
pretending that all the fuss was only about that silly '\0' byte they 
left in their license string (I wish they knew better not to do that --- 
there are millions of ways to achieve what they want).

Why didn't someone say that from the beginning, that what he (Marc 
Boucher's company) is doing was to lower the cost of avoiding to support 
the native Linux drivers and that is certainly damaging to us, though we 
can't really do anything about it because it is fair and perfectly legal. 
In fact, the only thing we can do is to make their life harder (i.e. 
by being unfair) and reduce the number of GPL-exported symbols to almost 
nothing.

Imho, it is best when people honestly state what the goal and the reasons 
of debate are, instead of unacceptable and unfair techniques such as lying 
about GPL directory content etc.

I think you (Jeff) have pointed out the key thing and it explained 
everything very nicely (at least to me, it did). Thank you. I always found 
your emails informative and to the point :)

Kind regards
Tigran

