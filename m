Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267190AbTBXPqc>; Mon, 24 Feb 2003 10:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267196AbTBXPqc>; Mon, 24 Feb 2003 10:46:32 -0500
Received: from 5-077.ctame701-1.telepar.net.br ([200.193.163.77]:20655 "EHLO
	5-077.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267190AbTBXPqc>; Mon, 24 Feb 2003 10:46:32 -0500
Date: Mon, 24 Feb 2003 12:56:34 -0300 (BRT)
From: Rik van Riel <riel@imladris.surriel.com>
To: thefly <thefly@acaro.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: What was wrong with merge-mem?
In-Reply-To: <20030224153930.GA674@tyler>
Message-ID: <Pine.LNX.4.50L.0302241256090.2206-100000@imladris.surriel.com>
References: <20030224153930.GA674@tyler>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2003, thefly wrote:

> 	i'm planning to port merge-mem to 2.4/2.5, i've started
> designing the whole stuff, but what i miss is what was wrong with the
> previous attempt. I googled the past posts but could'nt find much about
> it, just someone who reports security problems that i don't share.

I don't think there's anything wrong with mergemem.  Porting
it to be free of SMP races might be hairy, but it should work.

Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/
