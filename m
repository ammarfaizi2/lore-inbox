Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318325AbSHEHNu>; Mon, 5 Aug 2002 03:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318326AbSHEHNu>; Mon, 5 Aug 2002 03:13:50 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:14331 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318325AbSHEHNt>; Mon, 5 Aug 2002 03:13:49 -0400
Subject: Re: 2.4.19 IDE Partition Check issue
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200208050241.g752fBC12491@verdi.et.tudelft.nl>
References: <200208050241.g752fBC12491@verdi.et.tudelft.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Aug 2002 09:35:54 +0100
Message-Id: <1028536554.16555.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 03:41, Rob van Nieuwkerk wrote:
> I got myself a 2.4.19-ac3 tree, looked around in the IDE code and wasn't
> able to find the answer for my questions:
> 
> Any chance of lba48 working on a:
> 
>     - Promise Ultra66 (PDC20262: chipset revision 1) ?

This one should work, its one of the potential problem cases however

>     - Intel 82371AB PIIX4 IDE (rev 01) (On P-III BX-chipset mobo) ?
>     - Intel 82371FB PIIX IDE [Triton I] (rev 02) (On P-I Triton I mobo) ?

Intel all seems to be fine

