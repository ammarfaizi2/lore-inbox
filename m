Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287141AbSBCNc1>; Sun, 3 Feb 2002 08:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287145AbSBCNcS>; Sun, 3 Feb 2002 08:32:18 -0500
Received: from elin.scali.no ([62.70.89.10]:10505 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S287141AbSBCNcK>;
	Sun, 3 Feb 2002 08:32:10 -0500
Message-ID: <3C5D3BC9.CA9E24A@scali.com>
Date: Sun, 03 Feb 2002 14:31:53 +0100
From: Steffen Persvold <sp@scali.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Short question regarding generic_make_request()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Can generic_make_request() be called from interrupt level (or tasklet) ?

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency
