Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbTLLJhM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 04:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264532AbTLLJhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 04:37:12 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:6672 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264530AbTLLJhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 04:37:10 -0500
Date: Fri, 12 Dec 2003 09:39:21 +0000
From: Joe Thornber <thornber@sistina.com>
To: Zoltan NAGY <nagyz@nefty.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: crypto + dm = crash
Message-ID: <20031212093921.GB481@reti>
References: <Pine.LNX.4.58.0312111413080.22509@nefty.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312111413080.22509@nefty.hu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 02:14:16PM +0100, Zoltan NAGY wrote:
> Ohm, sorry, there was a typo in my last mail :)
> so, the sequence is:
> mkraid /dev/md0
> losetup -e aes /dev/loop0 /dev/md0
> mkraid /dev/loop0

Where does dm fit into this ?

- Joe
