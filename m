Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293092AbSDAWv7>; Mon, 1 Apr 2002 17:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312684AbSDAWvt>; Mon, 1 Apr 2002 17:51:49 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:30734 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S293092AbSDAWvc>; Mon, 1 Apr 2002 17:51:32 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A7742@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Jason Czerak'" <Jason-Czerak@Jasnik.net>
Cc: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>
Subject: RE: ECC memory and SMP lockups on Gateway 6400 server
Date: Mon, 1 Apr 2002 14:51:21 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Czerak wrote:
> 
> The OEM 128 and 64 meg stick of ECC that came with the machine 
> works fine. I got an aftermarket ECC stick that NT likes but 
> linux doesn't. 

Reminded me of the time I got burned by swap meet bargain memory vendor. The
timing config info in the DIMM's SPD EEPROM was very optimistic compared to
the datasheet spec for the actual memory chips used. 

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

