Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750696AbWIHIt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbWIHIt0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 04:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWIHIt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 04:49:26 -0400
Received: from aa004msr.fastwebnet.it ([85.18.95.67]:31163 "EHLO
	aa004msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750696AbWIHItZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 04:49:25 -0400
Date: Fri, 8 Sep 2006 10:47:55 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Victor Hugo <victor@vhugo.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] e-mail clients
Message-ID: <20060908104755.0cff2e64@localhost>
In-Reply-To: <4500B2FB.8050805@vhugo.net>
References: <4500B2FB.8050805@vhugo.net>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Sep 2006 17:02:03 -0700
Victor Hugo <victor@vhugo.net> wrote:

> As I've learned--most web-clients have a hard time sending text only 
> e-mail without
> wrapping every single line (not very good for patches).  Any suggestions 
> about which client to use on lkml?? Pine?? Mutt??
> Thunderbird?? Telnet??

Sylpheed / Sylpheed-Claws

I don't remember every version but with Sylpheed-Claws 2.4.0 you can
configure it to wrap (or not):

- typed text
- quoted text
- pasted text

(Configuration -> Prefereces -> Compose -> Wrapping)

Moreover you have the "Insert File" button that inserts a file
"inline" (for wrapping it follows the "pasted text" rule).


Other useful things you can set are:
	outgoing encodig (I use ISO-8859-15)
	trensfer encoding (I use 8bit)

NOTE: if he can he falls back to US-ASCII / 7bit

-- 
	Paolo Ornati
	Linux 2.6.18-rc6 on x86_64
