Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261454AbSJHOdP>; Tue, 8 Oct 2002 10:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261328AbSJHOdP>; Tue, 8 Oct 2002 10:33:15 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:48601 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261454AbSJHOdO>; Tue, 8 Oct 2002 10:33:14 -0400
Date: Tue, 8 Oct 2002 11:38:36 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: "J.A. Magallon" <jamagallon@able.es>
Cc: procps-list@redhat.com, <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] procps 2.0.10
In-Reply-To: <20021008143145.GA1560@werewolf.able.es>
Message-ID: <Pine.LNX.4.44L.0210081135290.1909-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, J.A. Magallon wrote:

> It also kills the 'states' part, things are beginning to spread past 80
> columns...is it very important ?

Yes, things should stay within 80 lines.

> I am gettin also strange outputs sometimes, with a ton of digits in
> decimal parts.

Wait... I remember fixing that bug.  On 2.4 kernels iowait
should always be 0.0% and it always is 0.0% here.

I have no idea why it's displaying a wrong value on your
system, unless you somehow managed to run against a wrong
libproc.so (shouldn't happen).

regards,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

