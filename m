Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267584AbRGSPPl>; Thu, 19 Jul 2001 11:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267594AbRGSPPb>; Thu, 19 Jul 2001 11:15:31 -0400
Received: from t2.redhat.com ([199.183.24.243]:39155 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S267584AbRGSPP1>; Thu, 19 Jul 2001 11:15:27 -0400
Message-ID: <3B56F992.915D3DCA@redhat.com>
Date: Thu, 19 Jul 2001 16:15:30 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-5smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Edouard Soriano <e_soriano@dapsys.com>, linux-kernel@vger.kernel.org
Subject: Re: 1GB system working with 64MB
In-Reply-To: <20010719.14393700@dap21.dapsys.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Edouard Soriano wrote:
> 
> Hello Folks,
> 
> Environment: linux 2.2.16smp
> RedHat 7.0


> My problem are the 63892K

If you upgrade to the 2.2.19 kernel, this will just work,
no need for extra options. (Red Hat also has a 2.2.19 kernel 
available as errata release for 7.0)
