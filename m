Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVBGMZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVBGMZh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 07:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVBGMZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 07:25:36 -0500
Received: from [195.23.16.24] ([195.23.16.24]:39297 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261407AbVBGMZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 07:25:17 -0500
Message-ID: <42075E0A.2010802@grupopie.com>
Date: Mon, 07 Feb 2005 12:24:42 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jjluza@yahoo.fr
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm1 - broken bttv ?
References: <200502051922.25001.jjluza@yahoo.fr> <42056065.2000504@eyal.emu.id.au> <200502060255.01758.jjluza@yahoo.fr>
In-Reply-To: <200502060255.01758.jjluza@yahoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jjluza wrote:
> Eyal Lebedinsky wrote
> 
>>I am having bttv problems with vanilla -rc3. Does it work for you?
> 
> 
> I don't know, as I said I didn't test kernel between 2.6.10 and 
> 2.6.11-rc3-mm1.
> Sorry.
> If I have time enough later, I can test 2.6.11-rc3.
> Since I don't really know if it's the good place to talk about that, I decided 
> to report this bug on bugzilla too. Maybe you can post your problem here :
> http://bugzilla.kernel.org/show_bug.cgi?id=4171

Other people with similar problems reported that the attached patch from 
  Gerd Knorr fixed the problem for them.

If you try it out and it fixes the problem for you, don't forget to 
report the fix in bugzilla too, so that others can use that info (and 
prevent having open bugs there for things that are already fixed :).

I hope this helps,

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
