Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278039AbRJIWtP>; Tue, 9 Oct 2001 18:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278040AbRJIWtF>; Tue, 9 Oct 2001 18:49:05 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:33551 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S278039AbRJIWsw>; Tue, 9 Oct 2001 18:48:52 -0400
X-Apparently-From: <trever?adams@yahoo.com>
Subject: Re: iptables in 2.4.10, 2.4.11pre6 problems
From: "Trever L. Adams" <trever_adams@yahoo.com>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: "Jeffrey W. Baker" <jwbaker@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Apparently-To: trever_adams@yahoo.com via web20408.mail.yahoo.com; 09 Oct
	2001 15:46:43 -0700 (PDT)
X-Track: 1: 40
In-Reply-To: <Pine.LNX.4.33.0110091129190.209-100000@desktop>
In-Reply-To: <Pine.LNX.4.33.0110100045490.24292-100000@Expansa.sns.it>
In-Reply-To: <Pine.LNX.4.33.0110100045490.24292-100000@Expansa.sns.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.09.08.08 (Preview Release)
Date: 09 Oct 2001 18:49:43 -0400
Message-Id: <1002667785.4093.13.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-10-09 at 18:46, Luigi Genoni wrote:
> stupid question...
> have you got a rule like
> 
> iptables -A INPUT -m unclean -j DROP
> 
> enabled?

I do not know what unclean means, so I don't know.

I have one that only accepts NEW from the inside.
I have one that accepts all ESTABLISHED,RELATED.
I have one that drops NEW,INVALID from ppp0 (outside world).

Trever


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

