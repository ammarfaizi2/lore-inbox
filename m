Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271113AbTGPV0s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 17:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271118AbTGPV0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 17:26:48 -0400
Received: from AMarseille-107-1-3-129.w80-11.abo.wanadoo.fr ([80.11.1.129]:33920
	"EHLO diablo") by vger.kernel.org with ESMTP id S271113AbTGPV0r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 17:26:47 -0400
Message-ID: <3F15C76C.7080105@free.fr>
Date: Wed, 16 Jul 2003 23:45:16 +0200
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030704 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Duncan Sands <baldrick@wanadoo.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Oops report] (ppp/pppoatm)... explanation found !
References: <3F157830.8030402@free.fr> <3F15AF87.3000500@free.fr> <3F15BE12.3000704@free.fr> <200307162317.16785.baldrick@wanadoo.fr>
In-Reply-To: <200307162317.16785.baldrick@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, it won't be necessary : it appears that Chas Williams was already 
aware of the bug and will probably send a patch for that shortly.  8-)

Best regards,

Vincent

Duncan Sands wrote:
>>I really believe this is a kernel bug that should be fixed (and most
>>probably a pppoatm one : I don't remember ever getting such an error
>>when launching pppd with my pcmcia V90 modem disconnected), but from [1]
>>it's not clear to me who is the pppoatm kernel maintainer these days :
>>anybody knows to whom I should forward this bugreport ?
> 
> 
> Try linux-atm-general@lists.sourceforge.net.
> 
> All the best,
> 
> Duncan.


