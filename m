Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135175AbRAJJdm>; Wed, 10 Jan 2001 04:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135191AbRAJJdb>; Wed, 10 Jan 2001 04:33:31 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:5136 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S135175AbRAJJdZ>; Wed, 10 Jan 2001 04:33:25 -0500
Date: Wed, 10 Jan 2001 10:33:20 +0100
From: Gábor Lénárt <lgb@vega.digitel2002.hu>
To: linux-kernel@vger.kernel.org
Subject: pretending a network interface
Message-ID: <20010110103320.B13083@vega.digitel2002.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
X-Operating-System: vega Linux 2.2.18 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is it possible somehow for a process to pretending a functional network
interface? I mean some emulator I develope requires to have network
capability. On the real machine it will run it has got serial interface
to connect to PC. But I develope it under Linux first, and I try to
test it. It would be cool to have something which can be fed by data and
trasmit it as it come from a network interface. According for example vice,
it is possible to use a serial port, which is linked to another serial port
of the same machine. But this is ugly and I haven't got two free serial
port either.

- Gabor

-- 
 --[ Gábor Lénárt ]---[ Vivendi Telecom Hungary ]--[ lgb@supervisor.hu ]--
 U have 8 bit comp or chip of them and it's unused or to be sold? Call me!
 -------[ +36 30 2270823 ]------> LGB <-----[ Linux/UNIX/8bit 4ever ]-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
