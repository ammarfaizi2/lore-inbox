Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278069AbRJIXsB>; Tue, 9 Oct 2001 19:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278070AbRJIXrv>; Tue, 9 Oct 2001 19:47:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:758 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S278069AbRJIXrr>; Tue, 9 Oct 2001 19:47:47 -0400
Message-ID: <3BC38CB1.23DCD762@mvista.com>
Date: Tue, 09 Oct 2001 16:48:01 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: where are the shrd/shld instructions
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These two instructions are in the x86 handbook, but the gas assembler
seems not to recognize them.  Any one know where I might find a
translation list from intel opcodes to gas opcodes?

George
