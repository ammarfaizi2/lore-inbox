Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261796AbSIXUzT>; Tue, 24 Sep 2002 16:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261803AbSIXUzT>; Tue, 24 Sep 2002 16:55:19 -0400
Received: from tantale.fifi.org ([216.27.190.146]:32640 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S261796AbSIXUzS>;
	Tue, 24 Sep 2002 16:55:18 -0400
To: James Stevenson <james@stev.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19: oops in ide-scsi
References: <87n0q8tcs8.fsf@ceramic.fifi.org>
	<1032891985.2035.1.camel@god.stev.org>
From: Philippe Troin <phil@fifi.org>
Date: 24 Sep 2002 14:00:17 -0700
In-Reply-To: <1032891985.2035.1.camel@god.stev.org>
Message-ID: <87smzzksri.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Stevenson <james@stev.org> writes:

> Hi
> 
> i am glad somebody else sees the same crash as me the
> request Q gets set to NULL for some reson then tries to
> increment a stats counter in the null pointer.
> i know what the bug is i just dont know how to fix it :>

I'm not sure which Q you're talking about.
Is that rq (in idescsi_pc_intr())?

Phil.
