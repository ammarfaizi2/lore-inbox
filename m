Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265085AbRF0LeC>; Wed, 27 Jun 2001 07:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264928AbRF0Ldw>; Wed, 27 Jun 2001 07:33:52 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:30340 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264934AbRF0Lds>;
	Wed, 27 Jun 2001 07:33:48 -0400
Message-ID: <3B39C4C3.C35D9900@mandrakesoft.com>
Date: Wed, 27 Jun 2001 07:34:27 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Silviu Marin-Caea <silviu@delrom.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtek 8139 driver or sucky hardware?
In-Reply-To: <20010627105256.2e75fdca.silviu@delrom.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Silviu Marin-Caea wrote:
> I have a server that had a Realtek 8139 card that worked nicely under
> normal circumstances.
[...]
> This crazy situation had the server freeze solid, with only cold boot as
> remedy.

Driver.  Crash fix is in 2.4.6-pre5, and a more complete fix should be
out in the next day or two.

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
