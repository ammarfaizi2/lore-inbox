Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275280AbTHMRJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 13:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275279AbTHMRJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 13:09:29 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:58522 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S275280AbTHMRJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 13:09:28 -0400
Date: Wed, 13 Aug 2003 14:08:32 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@localhost.localdomain
To: Jim Gifford <maillist@jg555.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
In-Reply-To: <076901c361ae$9a105030$3400a8c0@W2RZ8L4S02>
Message-ID: <Pine.LNX.4.44.0308131407090.5194-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Aug 2003, Jim Gifford wrote:

> Marcelo,
>     Could this be related to the issues I was having. Since rc1 I have not
> had any problems, and I have all the iptables stuff running again. My
> machine is smp and is using ext3.

Jim,

Dont think so. Your problems were caused by additional netfilter patches 
or the dazuko module -- Stephan is not using any of those. 

