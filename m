Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030859AbWI0VV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030859AbWI0VV3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 17:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030869AbWI0VV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 17:21:29 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:11795 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1030859AbWI0VV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 17:21:28 -0400
Date: Wed, 27 Sep 2006 17:20:52 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Martin Filip <bugtraq@smoula.net>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: forcedeth - WOL
Message-ID: <20060927212046.GA25022@tuxdriver.com>
References: <1159379441.9024.7.camel@archon.smoula-in.net> <200609271935.12969.s0348365@sms.ed.ac.uk> <1159388774.10054.1.camel@archon.smoula-in.net> <20060927204845.GA17803@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060927204845.GA17803@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 10:48:45PM +0200, Francois Romieu wrote:
> Martin Filip <bugtraq@smoula.net> :
> [...]
> > no.. I don't think it's my problem
> 
> Is is similar to http://bugzilla.kernel.org/show_bug.cgi?id=6398 ?

Shot in the dark, but do either the cited bug or the one reported
in this thread exhibit the "MAC address byte swapping" behavior to
which forcedeth is prone?

Just checkin'...

John
-- 
John W. Linville
linville@tuxdriver.com
