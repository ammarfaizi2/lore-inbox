Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132425AbREHMvW>; Tue, 8 May 2001 08:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132482AbREHMvM>; Tue, 8 May 2001 08:51:12 -0400
Received: from [209.225.10.21] ([209.225.10.21]:8354 "HELO mailrelay.local")
	by vger.kernel.org with SMTP id <S132425AbREHMu5>;
	Tue, 8 May 2001 08:50:57 -0400
Message-ID: <3AF7C46B.5655D1CA@elsitio.com.ar>
Date: Tue, 08 May 2001 10:03:23 +0000
From: Federico Edelman Anaya <fedelman@elsitio.com.ar>
Reply-To: fedelman@elsitio.com.ar
Organization: El Sitio
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: fs.file-max
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! ... In a Linux Kernel ...

What can I do to test the FD limit? ... Because, the FD limit is set in
/proc/sys/fs/file-max, sample:

echo "2048" > /proc/sys/fs/file-max
ulimit -n 8192

In this case ... the FD limit = 8192 :( ... when the limit should be
2048?

I wrote a perl script for the test ... anybody known a "C" program for
test the FD limit?


Thanks ...!

