Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266107AbTGDSxu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 14:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266109AbTGDSxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 14:53:50 -0400
Received: from ip212-226-133-178.adsl.kpnqwest.fi ([212.226.133.178]:12160
	"EHLO jumper") by vger.kernel.org with ESMTP id S266107AbTGDSxt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 14:53:49 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: netstat oopses 2.5.74
References: <87n0fv7gio.fsf@jumper.lonesom.pp.fi>
	<20030704.010454.101761988.yoshfuji@linux-ipv6.org>
From: Jaakko Niemi <liiwi@lonesom.pp.fi>
Date: Fri, 04 Jul 2003 22:08:16 +0300
In-Reply-To: <20030704.010454.101761988.yoshfuji@linux-ipv6.org> (YOSHIFUJI
 Hideaki's message of "Fri, 04 Jul 2003 01:04:54 +0900 (JST)")
Message-ID: <87of0a3yan.fsf@jumper.lonesom.pp.fi>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

YOSHIFUJI Hideaki / ИЈСА <yoshfuji@linux-ipv6.org> writes:

> Hello.
>
> In article <87n0fv7gio.fsf@jumper.lonesom.pp.fi> (at Thu, 03 Jul 2003 18:54:07 +0300), Jaakko Niemi <liiwi@lonesom.pp.fi> says:
>
>>  I can reproduce attached oops by running 'netstat -na' after 
>>  logging in. Changing compiler from gcc 3.3 to 2.95 does not
>>  seem to change things. Please cc me on replies. 
>
> Please apply this patch:
> http://bugme.osdl.org/attachment.cgi?id=476&action=view

 Thanks, works perfectly.
 
                --j
