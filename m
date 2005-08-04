Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVHDCgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVHDCgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 22:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVHDCgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 22:36:13 -0400
Received: from web8406.mail.in.yahoo.com ([202.43.219.154]:32606 "HELO
	web8406.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S261729AbVHDCgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 22:36:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4lfH0rqfK+ItIk/AZ6AFPIqUBrDGJxywVeZUoWF/IkPBLPcnmIkcgLIhN4h8W+CzujnqYaPQZxvn2UmJrFWSMG3uynYztU9d0s+dOCqbCSgsvSZWXsfboxx5fj5+3YM88Qgo+J8ge2j2EXua/IFKDrF4p9tI0yEmHMpil0hQ8o8=  ;
Message-ID: <20050804023604.45606.qmail@web8406.mail.in.yahoo.com>
Date: Thu, 4 Aug 2005 03:36:04 +0100 (BST)
From: Chandrasekhar Nagaraj <chandrasekhar_nagaraj@yahoo.co.in>
Subject: Regarding PCIBIOS_MIN_MEM and PCIBIOS_MIN_IO
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am writing a driver for the PCI controller for the
2.4.17 kernel.
I found out that we need to define 2 macros
PCIBIOS_MIN_MEM and PCIBIOS_MIN_IO. What does these
macros mean?
I have a ARM board with Memory space starting at
0x6000_0000 and IO space starting at 0x7000_0000. So
does this mean that I have to set the above values to
these macros?

Thanks and Regards
Chandrasekhar


	

	
		
__________________________________________________________
Free antispam, antivirus and 1GB to save all your messages
Only in Yahoo! Mail: http://in.mail.yahoo.com
