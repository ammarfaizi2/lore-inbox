Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269115AbRGaAWs>; Mon, 30 Jul 2001 20:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267947AbRGaAWi>; Mon, 30 Jul 2001 20:22:38 -0400
Received: from pD951F41A.dip.t-dialin.net ([217.81.244.26]:1800 "EHLO
	emma1.emma.line.org") by vger.kernel.org with ESMTP
	id <S267908AbRGaAW3>; Mon, 30 Jul 2001 20:22:29 -0400
Date: Tue, 31 Jul 2001 02:22:36 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Lawrence Greenfield <leg+@andrew.cmu.edu>
Cc: Rik van Riel <riel@conectiva.com.br>,
        "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Chris Wedgwood <cw@f00f.org>, Chris Mason <mason@suse.com>
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010731022236.D28253@emma1.emma.line.org>
Mail-Followup-To: Lawrence Greenfield <leg+@andrew.cmu.edu>,
	Rik van Riel <riel@conectiva.com.br>,
	"Patrick J. LoPresti" <patl@cag.lcs.mit.edu>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Chris Wedgwood <cw@f00f.org>, Chris Mason <mason@suse.com>
In-Reply-To: <Pine.LNX.4.33L.0107301320370.11893-100000@imladris.rielhome.conectiva> <s5gvgkacqlm.fsf@egghead.curl.com> <200107301711.f6UHBWHE001945@acap-dev.nas.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200107301711.f6UHBWHE001945@acap-dev.nas.cmu.edu>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001, Lawrence Greenfield wrote:

> The idea that Linux fsync() doesn't actually make the file survive
> reboots is pretty ridiculous.

That doesn't apply to ReiserFS or ext3fs, it does apply to ext2fs and
possibly others.

-- 
Matthias Andree
