Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265231AbUAESX6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 13:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUAESX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 13:23:58 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:59788 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S265231AbUAESX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 13:23:56 -0500
Date: Mon, 5 Jan 2004 19:23:54 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Diego Calleja <grundig@teleline.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mremap bug and 2.4?
Message-ID: <20040105182354.GH1947@louise.pinerecords.com>
References: <20040105145421.GC2247@rdlg.net> <Pine.LNX.4.58L.0401051323520.1188@logos.cnet> <20040105181053.6560e1e3.grundig@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040105181053.6560e1e3.grundig@teleline.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan-05 2004, Mon, 18:10 +0100
Diego Calleja <grundig@teleline.es> wrote:

> El Mon, 5 Jan 2004 13:26:23 -0200 (BRST) Marcelo Tosatti <marcelo.tosatti@cyclades.com> escribió:
> 
> > On Mon, 5 Jan 2004, Robert L. Harris wrote:
> > > Just read this on full disclosure:
> > >
> > > http://isec.pl/vulnerabilities/isec-0013-mremap.txt
> [...]
> > It is possible that the problem is exploitable. There is no known public
> > exploit yet, however.
> > 
> > 2.4.24 includes a fix for this (mm/mremap.c diff)
> 
> It names 2.2 too. Is there a fix for 2.2?

Ask Alan.  He's not following the kernel mailing list too closely these days.

-- 
Tomas Szepe <szepe@pinerecords.com>
