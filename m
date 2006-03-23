Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422715AbWCWWbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422715AbWCWWbj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWCWWbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:31:39 -0500
Received: from smtp1.wanadoo.fr ([193.252.22.30]:11847 "EHLO smtp1.wanadoo.fr")
	by vger.kernel.org with ESMTP id S964938AbWCWWbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:31:38 -0500
X-ME-UUID: 20060323223131744.B5A9B1C0060E@mwinf0112.wanadoo.fr
Message-ID: <44232156.6060701@worldonline.fr>
Date: Thu, 23 Mar 2006 23:29:42 +0100
From: Sylvain Meyer <sylvain.meyer@worldonline.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; fr-FR; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: fr-fr, en-us
MIME-Version: 1.0
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [Linux-fbdev-devel] [PATCH] [git tree] Intel i9xx support for
 intelfb
References: <21d7e9970603221820p5c89e46fgbd9878a3c60eac0a@mail.gmail.com>	 <b00ca3bd0603222159t63ea0f4j38e085ecff5b93c8@mail.gmail.com> <21d7e9970603222209r45beeb99nccc6435b99b79154@mail.gmail.com> <44229D48.6040502@gmail.com>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Not for all the i2c ports. I will post my code tomorrow.

Regards
Sylvain

Antonino A. Daplas a écrit:

>Dave Airlie wrote:
>
>  
>
>>laptop users with these chipsets, getting DVI working is a bit more
>>work as there are external chips that need to be driven over i2c, so
>>I'll need to at least add i2c support to the i8xx driver. (I noticed
>>Sylvain has done some of this work before)..... I'd like to expose i2c
>>buses to userspace anyways....
>>    
>>
>
>Someone mentioned (I think it was Nicholas Boichat) that the i2c code
>of i810fb works for intelfb too, but I cannot verify that.
>
>Tony
>
>  
>



