Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTLOMO5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 07:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTLOMOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 07:14:55 -0500
Received: from intra.cyclades.com ([64.186.161.6]:53648 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263580AbTLOMOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 07:14:49 -0500
Date: Mon, 15 Dec 2003 10:03:29 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Frank van Maarseveen <frankvm@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 Oops
In-Reply-To: <20031215110228.GA15976@iapetus.localdomain>
Message-ID: <Pine.LNX.4.44.0312151000430.5362-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Dec 2003, Frank van Maarseveen wrote:

> Got a new kernel oops. Same machine as the previous reported oops
> in journal_try_to_free_buffers(). Something seems definately wrong
> in 2.4.23.
> 
> Marcelo, I'll follow your suggestion te revert a particular change.

Are you using SMP? 



