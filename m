Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293192AbSCEOjp>; Tue, 5 Mar 2002 09:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293194AbSCEOjh>; Tue, 5 Mar 2002 09:39:37 -0500
Received: from mail.siemens.no ([195.1.133.65]:60936 "EHLO osll010a.siemens.no")
	by vger.kernel.org with ESMTP id <S293192AbSCEOj2> convert rfc822-to-8bit;
	Tue, 5 Mar 2002 09:39:28 -0500
Message-ID: <49996CDF755FD311AA640090274E650D04310DEA@osll008a.siemens.no>
From: Jacobsson James <james.jacobsson@sbs.siemens.no>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [BETA-0.95] Sixth test release of Tigon3 driver
Date: Tue, 5 Mar 2002 15:43:00 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry..  That was ment as a private mail to Thomas.. 

(For those who are curious about the language, it's swedish, and I'm
offering Thomas the use of one of our switches)

Regard,
James Jacobsson

-----Original Message-----
From: Jacobsson James 
Sent: den 5 mars 2002 15:39
To: 'linux-kernel@vger.kernel.org'
Subject: RE: [BETA-0.95] Sixth test release of Tigon3 driver

Om du verkligen behöver testa detta, så har jag en Extreme-switch med ett
antal Giga-bit interfaces i den som du kan testa med..  (Ja, den stödjer 9K
MTU)

Finnes på Siemens Linderud om du är intresserad.. 

/James

-----Original Message-----
From: Thomas Langås [mailto:tlan@stud.ntnu.no] 
Sent: den 5 mars 2002 15:30
To: David S. Miller
Cc: linux-kernel@vger.kernel.org; jgarzik@mandrakesoft.com;
linux-net@vger.kernel.org
Subject: Re: [BETA-0.95] Sixth test release of Tigon3 driver

David S. Miller:
> Most gigabit switches don't support 9000 byte mtu :-)

Hmm, I found a document through google; Cisco Catalyst 4006 doesn't support
9KB MTUs, so I'll contact the networking guys and fix this, we want switches
that supports large MTUs :)

-- 
Thomas
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
