Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290744AbSAYR32>; Fri, 25 Jan 2002 12:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290743AbSAYR3T>; Fri, 25 Jan 2002 12:29:19 -0500
Received: from ns.suse.de ([213.95.15.193]:62221 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290744AbSAYR3C>;
	Fri, 25 Jan 2002 12:29:02 -0500
Date: Fri, 25 Jan 2002 18:29:01 +0100
From: Dave Jones <davej@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: David Weinehall <tao@acc.umu.se>, rwhron@earthlink.net,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.18pre4aa1
Message-ID: <20020125182901.J28068@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Rik van Riel <riel@conectiva.com.br>,
	David Weinehall <tao@acc.umu.se>, rwhron@earthlink.net,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020125061801.W1735@khan.acc.umu.se> <Pine.LNX.4.33L.0201251502230.32617-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0201251502230.32617-100000@imladris.surriel.com>; from riel@conectiva.com.br on Fri, Jan 25, 2002 at 03:03:16PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 03:03:16PM -0200, Rik van Riel wrote:
 
 > The -aa kernel seems to contain patches to a few dozen subsystems.
 > The -rmap patch is pretty much only VM changes.
 > You're right that this is not a strict VM vs VM comparison...

 Agreed. Andrea's tree seemed to gain quite a bit of a lead
 when bits of the lowlat patches were applied for eg.
 Just taking 00_vm_?? from ../people/andrea/.. would give better
 comparison for a head to head vm pissing contest. 

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
