Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264559AbUAFSQq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 13:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264591AbUAFSQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 13:16:46 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:39645 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S264559AbUAFSQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 13:16:42 -0500
Date: Tue, 6 Jan 2004 19:16:39 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0: atyfb broken
Message-ID: <20040106181639.GE11122@charite.de>
Mail-Followup-To: James Simmons <jsimmons@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20031230212609.GA4267@rootdir.de> <Pine.LNX.4.44.0401052230150.7347-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0401052230150.7347-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Simmons <jsimmons@infradead.org>:

> Can you try my latest patch. 
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

This patch did wonders for my laptop with neofb, for the FIRST TIME
since 2.5.x I get a usable FB when swithcing back from X11.

Great job!

atyfb at work, however got a nice blinking cursor, and when booting
the logo is fucked up and I've got some random chars on the screen.

Screenshot at request.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
Referat V a - Kommunikationsnetze -             AIM.  ralfpostfix
