Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263887AbRFFRav>; Wed, 6 Jun 2001 13:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263885AbRFFRal>; Wed, 6 Jun 2001 13:30:41 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:18843 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263851AbRFFRaY>;
	Wed, 6 Jun 2001 13:30:24 -0400
Message-ID: <3B1E68AB.CDD00F2C@mandrakesoft.com>
Date: Wed, 06 Jun 2001 13:30:19 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank Davis <fdavis112@juno.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patches sound driver locking issue
In-Reply-To: <383443482.991847258860.JavaMail.root@web395-wra.mail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Davis wrote:
> 
> Hello all,
>     I have attached patches against the following sound drivers to fix the locking issues mentioned in Alan's release notes for 2.4.5-ac9 . Please CC me on your comments to the code (I can address the issues quicker). Thanks.

Do these patches have the same problems that your es1371 patch did?

Let's make sure that is fixed first, and is solid.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
