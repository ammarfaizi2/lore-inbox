Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVFZIaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVFZIaM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 04:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVFZI2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 04:28:21 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:61097 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S261530AbVFZI1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 04:27:04 -0400
X-IronPort-AV: i="3.93,230,1115017200"; 
   d="scan'208"; a="194333661:sNHT29052604"
Message-ID: <42BE66C2.3000509@cisco.com>
Date: Sun, 26 Jun 2005 18:26:42 +1000
From: Lincoln Dale <ltd@cisco.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Valdis.Kletnieks@vt.edu, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>	 <42BCD93B.7030608@slaphack.com>	 <200506251420.j5PEKce4006891@turing-police.cc.vt.edu>	 <42BDA377.6070303@slaphack.com>	 <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu>	 <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com>
In-Reply-To: <42BE5DB6.8040103@slaphack.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Masover wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Lincoln Dale wrote:
>
>[...]
>
>  
>
>>this is the WHOLE point of standardization .. i don't think its that
>>Reiser4's EAs offer any more or less capabilities than standard EAs -
>>    
>>
>
>They do.  Reiser4's EAs can look like any other object -- files,
>folders, symlinks, whatever.  This is important, especially for
>transparency.
>  
>
it was accepted not so long ago that 'file-as-directory' and 'EA' are 
two different things, predominantly because existing tools and apps 
won't necessarily "do the right thing<tm>".

this has been discussed to death previously.  oh what a surprise.  
http://lwn.net/Articles/100271/


cheers,

lincoln.


cheers,

lincoln.
