Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270735AbTGNR73 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270736AbTGNR73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:59:29 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2948 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270735AbTGNR72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:59:28 -0400
Date: Mon, 14 Jul 2003 15:11:51 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: ajoshi@kernel.crashing.org
Cc: lkml <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org
Subject: Re: radeonfb patch for 2.4.22...
In-Reply-To: <Pine.LNX.4.10.10307141237001.27519-100000@gate.crashing.org>
Message-ID: <Pine.LNX.4.55L.0307141506020.8994@freak.distro.conectiva>
References: <Pine.LNX.4.10.10307141237001.27519-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Jul 2003 ajoshi@kernel.crashing.org wrote:

>
> Hi Marcelo,
>
> Is there any particular reason why you decided to merge Ben H.'s radeonfb
> update instead of the one I sent you?

I've decided to CC lkml because I think there are other people interested
in this discussion.

I merged his version because he sent me your update (0.1.8) plus his code
(which are useful fixes he has been working on).

It seems things are broken now due to a missing header, but he also sent
me that.

Do you have any objections to his fixes ?

