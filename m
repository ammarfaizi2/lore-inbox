Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263392AbRFAFUs>; Fri, 1 Jun 2001 01:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263393AbRFAFUi>; Fri, 1 Jun 2001 01:20:38 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:51864 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263392AbRFAFU2>;
	Fri, 1 Jun 2001 01:20:28 -0400
Message-ID: <3B172617.6183F39C@mandrakesoft.com>
Date: Fri, 01 Jun 2001 01:20:23 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: thunder7@xs4all.nl
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: interrupt problem with MPS 1.4 / not with MPS 1.1 ?
In-Reply-To: <3B16A7E3.1BD600F3@colorfullife.com> <20010531222708.A8295@middle.of.nowhere> <3B16AD5D.DEDB8523@colorfullife.com> <20010601071414.A871@middle.of.nowhere>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at the diff of "lspci -vvvxxx" between MPS1.1 and MPS1.4 (on the
same system) may be quite useful...  maybe I missed the earlier "lspci
-vvvxxx", but I only see one here...
-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
