Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272485AbRIKPoN>; Tue, 11 Sep 2001 11:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272489AbRIKPoE>; Tue, 11 Sep 2001 11:44:04 -0400
Received: from luggage.tecc.co.uk ([193.128.6.129]:37094 "HELO
	relay.tecc.co.uk") by vger.kernel.org with SMTP id <S272485AbRIKPnv>;
	Tue, 11 Sep 2001 11:43:51 -0400
Message-ID: <3B9E3F75.CAC7DAD2@tecc.co.uk>
Date: Tue, 11 Sep 2001 16:44:37 +0000
From: Ken Williams <ken@tecc.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18pre21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: srinivas.surabhi@wipro.com
CC: linux-kernel@vger.kernel.org
Subject: Re: how to see .so contents
In-Reply-To: <3B9E4E62.494FBAE4@wipro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"s.srinivas" wrote:
> 
> hi all,
> 
>     Its a silly question i tried with all my friends but of no use.
> Could any one tell me how to know the contents(modules) that
> are contained in any .so (shared objects) file.
> 
> say for ex. for archive  file    ar  -t  .a file name     is used  .




  I think what you want is 'objdump'

  try
        /usr/bin/objdump -f shared_object.so


  see the man pages for more info.


   Regards,


 Ken


 
> thank  u all in advance.
> 
> regards
> srinivas
> 
>   ------------------------------------------------------------------------
>                            Name: Wipro_Disclaimer.txt
>    Wipro_Disclaimer.txt    Type: Plain Text (text/plain)
>                        Encoding: 7bit
