Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312283AbSCYDQx>; Sun, 24 Mar 2002 22:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312285AbSCYDQn>; Sun, 24 Mar 2002 22:16:43 -0500
Received: from netlx009.civ.utwente.nl ([130.89.1.91]:25545 "EHLO
	netlx009.civ.utwente.nl") by vger.kernel.org with ESMTP
	id <S312283AbSCYDQb>; Sun, 24 Mar 2002 22:16:31 -0500
Date: Mon, 25 Mar 2002 04:16:22 +0100
From: Arjan Opmeer <a.d.opmeer@student.utwente.nl>
To: Andrew Morton <akpm@zip.com.au>
Cc: Arjan Opmeer <a.d.opmeer@student.utwente.nl>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Anyone else seen VM related oops on 2.4.18?
Message-ID: <20020325031622.GA805@Ado.student.utwente.nl>
In-Reply-To: <20020325005633.GA1121@Ado.student.utwente.nl> <Pine.LNX.4.44L.0203242200080.18660-100000@imladris.surriel.com> <20020325011139.GA1165@Ado.student.utwente.nl> <3C9E82DA.99D53C94@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2002 at 05:52:26PM -0800, Andrew Morton wrote:
> 
> Please ensure that the kernel was built with `verbose BUG reporting',
> under the kernel hacking menu.

Okay. Just built a new kernel with that option activated. Had some troubles
with unresolved symbols in essential modules that only building from a
completely new untarred kernel tree seemed to solve.

Running that kernel now and waiting again... :)


Arjan
