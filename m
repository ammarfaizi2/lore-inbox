Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266886AbTBQHA3>; Mon, 17 Feb 2003 02:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbTBQHA3>; Mon, 17 Feb 2003 02:00:29 -0500
Received: from angband.namesys.com ([212.16.7.85]:54412 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S266886AbTBQHA3>; Mon, 17 Feb 2003 02:00:29 -0500
Date: Mon, 17 Feb 2003 10:10:21 +0300
From: Oleg Drokin <green@namesys.com>
To: Morten Helgesen <morten.helgesen@nextframe.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.20 Oops]
Message-ID: <20030217101021.A21241@namesys.com>
References: <20030215143548.A11310@sexything>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030215143548.A11310@sexything>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, Feb 15, 2003 at 02:35:48PM +0100, Morten Helgesen wrote:

> keep getting this on an sql-server running 2.4.20. It happens during 
> backup of mysql databases. Easily reproducible. After the oops, processes
> trying to access /backup end up in 'D' state. Btw, filesystem
> is reiserfs. Anyone got a clue ?
> EIP:    0010:[try_to_free_buffers+20/228]    Not tainted

Hmm. Perhaps try to run memtest86 for some time to verify that your RAM is still ok?

Thank you.

Bye,
    Oleg
