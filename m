Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262989AbREaH2v>; Thu, 31 May 2001 03:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263022AbREaH2b>; Thu, 31 May 2001 03:28:31 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:55950 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262989AbREaH21>;
	Thu, 31 May 2001 03:28:27 -0400
Message-ID: <3B15F287.305FEAC5@mandrakesoft.com>
Date: Thu, 31 May 2001 03:28:07 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Yiping Chen <YipingChen@via.com.tw>
Cc: "'Frank Eichentopf'" <frei@hap-bb.de>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: via-rhine DFE-530TX rev A1
In-Reply-To: <611C3E2A972ED41196EF0050DA92E0760265D6B9@EXCHANGE2>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yiping Chen wrote:
> 
> Yes, please download the newest driver from D-Link, becuase the
> Win98 will change to D3 mode after it boot.
> So the Mac address can't be fetch in Linux.

Most drivers read the EEPROM in their probe phase to present this sort
of problem.

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
