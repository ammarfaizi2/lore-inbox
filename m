Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293184AbSCEOgF>; Tue, 5 Mar 2002 09:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293194AbSCEOfy>; Tue, 5 Mar 2002 09:35:54 -0500
Received: from mail.siemens.no ([195.1.133.65]:776 "EHLO osll010a.siemens.no")
	by vger.kernel.org with ESMTP id <S293184AbSCEOfm> convert rfc822-to-8bit;
	Tue, 5 Mar 2002 09:35:42 -0500
Message-ID: <49996CDF755FD311AA640090274E650D04310DE8@osll008a.siemens.no>
From: Jacobsson James <james.jacobsson@sbs.siemens.no>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [BETA-0.95] Sixth test release of Tigon3 driver
Date: Tue, 5 Mar 2002 15:39:15 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
