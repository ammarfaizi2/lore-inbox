Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbTJRDVa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 23:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbTJRDVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 23:21:30 -0400
Received: from codepoet.org ([166.70.99.138]:53139 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S261304AbTJRDV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 23:21:29 -0400
Date: Fri, 17 Oct 2003 21:21:27 -0600
From: Erik Andersen <andersen@codepoet.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: DervishD <raul@pleyades.net>, linux-kernel@vger.kernel.org
Subject: Re: Console escape sequences
Message-ID: <20031018032126.GA2106@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>, DervishD <raul@pleyades.net>,
	linux-kernel@vger.kernel.org
References: <20031018000531.GB17198@DervishD> <20031017201052.2c8d3221.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031017201052.2c8d3221.rddunlap@osdl.org>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Oct 17, 2003 at 08:10:52PM -0700, Randy.Dunlap wrote:
> On Sat, 18 Oct 2003 02:05:31 +0200 DervishD <raul@pleyades.net> wrote:
> 
> |     Hi all :)
> | 
> |     Where should I look if I want to know which ANSI escape codes (or
> | any other escape codes) the console accepts? I know that I can send
> | ESC[1m; to the console for getting bold text, for example, and I know
> | more codes, extracted from the terminfo entries and places like that,
> | but I would like to know if somewhere in the sources is something
> | like a list of supported codes.
> 
> Maybe 'man 4 console_chars' ?

s/console_chars/console_codes/

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
