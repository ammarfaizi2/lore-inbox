Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317232AbSHTNco>; Tue, 20 Aug 2002 09:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317189AbSHTNco>; Tue, 20 Aug 2002 09:32:44 -0400
Received: from mailserver1.hrz.tu-darmstadt.de ([130.83.126.41]:62480 "EHLO
	mailserver1.hrz.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id <S317232AbSHTNcn>; Tue, 20 Aug 2002 09:32:43 -0400
Message-ID: <3D6245DC.3A189656@hrzpub.tu-darmstadt.de>
Date: Tue, 20 Aug 2002 15:36:28 +0200
From: Jens Wiesecke <j_wiese@hrzpub.tu-darmstadt.de>
X-Mailer: Mozilla 4.75 [de] (Windows NT 5.0; U)
X-Accept-Language: de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: P4 with i845E not booting with 2.4.19 / 3.5.31
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have the problem that my new P4 (1.6 GHz Northwood) box with i845E
chipset doesn't boot with the 2.4.19(-pre2) kernel nor with the 2.5.31
kernel (I also tested RedHat and Suse kernels without success). But it
does boot with the late 2.2 series kernels (I tested 2.2.19 and 2.2.21).
After displaying the message "umcompressing linux ... ok. Bootig the
kernel" nothing else happens.

Can anybody please give me a hint how I can look for further debug
information ?

Best regards
-- 
Jens Wiesecke
Institute for Makromolecular Chemistry
64287 Darmstadt
Germany

e-mail: j_wiese@hrzpub.tu-darmstadt.de
