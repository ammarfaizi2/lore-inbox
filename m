Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbTLLNV4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 08:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264563AbTLLNV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 08:21:56 -0500
Received: from nefty.hu ([195.70.37.175]:21646 "EHLO nefty.hu")
	by vger.kernel.org with ESMTP id S264560AbTLLNVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 08:21:55 -0500
Date: Fri, 12 Dec 2003 14:22:20 +0100 (CET)
From: Zoltan NAGY <nagyz@nefty.hu>
To: Joe Thornber <thornber@sistina.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: crypto + dm = crash
In-Reply-To: <20031212093921.GB481@reti>
Message-ID: <Pine.LNX.4.58.0312121420550.23801@nefty.hu>
References: <Pine.LNX.4.58.0312111413080.22509@nefty.hu> <20031212093921.GB481@reti>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Dec 2003, Joe Thornber wrote:

> Where does dm fit into this ?
As far as I know, LVM2 uses dm..

oh, hm. although, it is NOT a problem with dm (as far as I can tell), it
IS a problem with the crypto or whatever..

sorry for misleading again, just when I first tried it I used lvm2 on
encrypted /dev/loop0, and this is what misleaded me..

Regards,

--
Zoltan NAGY,
Network Administrator

