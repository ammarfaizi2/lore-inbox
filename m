Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTESUzD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 16:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbTESUzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 16:55:03 -0400
Received: from 213-97-199-90.uc.nombres.ttd.es ([213.97.199.90]:62428 "HELO
	fargo") by vger.kernel.org with SMTP id S262543AbTESUzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 16:55:02 -0400
Date: Mon, 19 May 2003 23:12:48 +0200
From: David =?iso-8859-15?Q?G=F3mez?= <david@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: e100 driver
Message-ID: <20030519211248.GA7633@fargo>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Is there some known problem in 2.4.20 with the e100 driver? I've been seen
lately a lot of errors in my kernel logs, with the messages:

<31>May 19 09:05:42 kernel: hw tcp v4 csum failed
<31>May 19 09:11:11 kernel: icmp v4 hw csum failure

repeated several times. I've switched back to the eepro100 driver and the
checksum errors messages seems to go away...

Thanks,

-- 
David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra
