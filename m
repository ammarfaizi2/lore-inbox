Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269205AbUISKEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269205AbUISKEj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 06:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269206AbUISKEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 06:04:39 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:24506 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S269205AbUISKEg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 06:04:36 -0400
Message-ID: <414D598F.6090302@namesys.com>
Date: Sun, 19 Sep 2004 13:03:59 +0300
From: Yury Umanets <umka@namesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: "Wise, Jeremey" <jeremey.wise@agilysys.com>,
       "David B. Stevens" <dsteven3@maine.rr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel or Grub bug.
References: <200409022103.i82L2rm1003486@laptop11.inf.utfsm.cl>
In-Reply-To: <200409022103.i82L2rm1003486@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

>"Wise, Jeremey" <jeremey.wise@agilysys.com> said:
>
>[...]
>  
>
>>My system is all reiserfs though the Fedora core box I also did testing
>>on was EXT3. 
>>    
>>
>
>grub can't handle ReiserFS.
>  
>
May be you have non standard reiserfs journal size? If so, then you 
probably want to apply special patch for that...

-- 
umka

