Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSHFThr>; Tue, 6 Aug 2002 15:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315442AbSHFThr>; Tue, 6 Aug 2002 15:37:47 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:50385 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S315431AbSHFThq>; Tue, 6 Aug 2002 15:37:46 -0400
Message-ID: <3D502611.26B28B8E@nortelnetworks.com>
Date: Tue, 06 Aug 2002 15:40:01 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       abraham@2d3d.co.za
Subject: Re: ethtool documentation
References: <Pine.LNX.3.95.1020806151104.25149A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:

> Because of this, there is no such thing as 'unused eeprom space' in
> the Ethernet Controllers. Be careful about putting this weapon in
> the hands of the 'public'. All you need is for one Linux Machine
> on a LAN to end up with the same IEEE Station Address as another
> on that LAN and connectivity to everything on that segment will
> stop. You do this once at an important site and Linux will get a
> very black eye.

Can't we already tell cards (some of them anyway) what MAC address to use when
sending packets?  This doesn't overwrite the EEPROM, but it does last for that
session...

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
