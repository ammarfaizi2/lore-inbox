Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264787AbSJaJih>; Thu, 31 Oct 2002 04:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264789AbSJaJif>; Thu, 31 Oct 2002 04:38:35 -0500
Received: from lech.pse.pl ([194.92.3.7]:1499 "EHLO lech.pse.pl")
	by vger.kernel.org with ESMTP id <S264787AbSJaJie>;
	Thu, 31 Oct 2002 04:38:34 -0500
Date: Thu, 31 Oct 2002 10:44:51 +0100
From: Lech Szychowski <lech.szychowski@pse.pl>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's left over.
Message-ID: <20021031094451.GA23213@lech.pse.pl>
Reply-To: Lech Szychowski <lech.szychowski@pse.pl>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> <Pine.LNX.4.44L.0210310105160.1697-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0210310105160.1697-100000@imladris.surriel.com>
Organization: Polskie Sieci Elektroenergetyczne S.A.
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, people use it.  Not quite sure why though, I guess ACLs
> buy some flexibility over the user/group/other model but if
> the "unlimited groups" patch goes in (is in?) I'm happy ;)

Correct me if I'm wrong but I believe a process has to be
restarted to have its group membership list changed? 

That's a huge difference from ACL behavior which allow for changes to
file access rights without the need to restart the accessing process.

-- 
	Leszek.

-- lech7@pse.pl 2:480/33.7          -- REAL programmers use INTEGERS --
-- speaking just for myself...
