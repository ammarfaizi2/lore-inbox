Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289167AbSAVFfB>; Tue, 22 Jan 2002 00:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289169AbSAVFev>; Tue, 22 Jan 2002 00:34:51 -0500
Received: from paloma16.e0k.nbg-hannover.de ([62.181.130.16]:47074 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S289167AbSAVFeo>; Tue, 22 Jan 2002 00:34:44 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "Partha Narayanan" <partha@us.ibm.com>
Subject: Re: Performance Results for Ingo's O(1)-scheduler
Date: Tue, 22 Jan 2002 06:34:34 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020122053448Z289167-13997+8048@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 22. January 2002 00:03, you wrote:
> Here are some results from running VolanoMark on different
> versions of O(1)-scheduler based on 2.4.17.
>
> VolanoMark 2.1.2 Loopback test,
> 8-way 700MHZ Pentium III,
> 1GB Kernel,
> IBM JVM 1.3. (build cx 130 -20010626)
> Throughput in msg/sec
>
>
> KERNEL              UP          4-way       8-way
> =========  ======      ======      ======
>
> 2.4.17              11005       15894       11595
[-]

Would you be so kind to redo it with 2.4.18pre2aa2 (Andrea's 10_vm-22) stuff?

Thank you very much.

	Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
