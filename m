Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266158AbRF2Syy>; Fri, 29 Jun 2001 14:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266154AbRF2Sye>; Fri, 29 Jun 2001 14:54:34 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:12782 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266155AbRF2Sya>;
	Fri, 29 Jun 2001 14:54:30 -0400
Message-ID: <3B3CCF08.3E2E6AA8@mandrakesoft.com>
Date: Fri, 29 Jun 2001 14:55:04 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Jasen <jjasen@datafoundation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a couple of NICs that don't NIC
In-Reply-To: <Pine.LNX.4.30.0106291223560.9716-100000@flash.datafoundation.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Jasen wrote:
> kernels: 2.4.4
> 
> drivers used: kernel 8139too
> 
> symptoms: the system would hang under heavy network traffic, and need to
> be powercycled backed to life.

fixed in 2.4.6-pre6

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
