Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317395AbSFHL1L>; Sat, 8 Jun 2002 07:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317396AbSFHL1K>; Sat, 8 Jun 2002 07:27:10 -0400
Received: from web14403.mail.yahoo.com ([216.136.174.60]:5971 "HELO
	web14403.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317395AbSFHL1J>; Sat, 8 Jun 2002 07:27:09 -0400
Message-ID: <20020608112710.23692.qmail@web14403.mail.yahoo.com>
Date: Sat, 8 Jun 2002 04:27:10 -0700 (PDT)
From: manjuanth n <manju_tt@yahoo.com>
Subject: need help
To: linux-kernel@vger.kernel.org
Cc: manju_tt@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear sir,
 we have SAN environment  with hitachi  storage box
and  brocade  switch. we are trying to  install Linux 
with  qlogic  HBA card.  we  are facing strange 
problems 
1. If  we  disable LUN 0  we will not be able to see
any LUNs on liunx  machine
2. If we  enable  LUN 0  we can  see all the  LUNS 
but  it  should be in sequence  i.e LUN0 ,1,2 , 3  etc
if we disable  LUN 3  we will not be able  to see LUNS
4 and  the  rest
 Is the  above things  are limitation of linux.
Linux  machine is  running with  2.4.18 kernel

Is there any solutions for  these problems? 

Thanks and Regards
Manjuanth


__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
