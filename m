Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267947AbTAHWfK>; Wed, 8 Jan 2003 17:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267946AbTAHWfK>; Wed, 8 Jan 2003 17:35:10 -0500
Received: from home.wiggy.net ([213.84.101.140]:28820 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S267947AbTAHWfI>;
	Wed, 8 Jan 2003 17:35:08 -0500
Date: Wed, 8 Jan 2003 23:43:40 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Andrew McGregor <andrew@indranet.co.nz>
Cc: Fabio Massimo Di Nitto <fabbione@fabbione.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: ipv6 stack seems to forget to send ACKs
Message-ID: <20030108224339.GO22951@wiggy.net>
Mail-Followup-To: Andrew McGregor <andrew@indranet.co.nz>,
	Fabio Massimo Di Nitto <fabbione@fabbione.net>, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <20030108130850.GQ22951@wiggy.net> <Pine.LNX.4.51.0301081849550.564@diapolon.int.fabbione.net> <78180000.1042055993@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78180000.1042055993@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Andrew McGregor wrote:
> Probably on the server's side it got an ICMP Host Unreachable or two as 
> some router updated its tables, and decided to close the connection.

The fact that this problem does not seem to occur when using a window
XP client seems to contradict the suggestions that it may be a router
problem.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
