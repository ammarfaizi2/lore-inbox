Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbRHJLrG>; Fri, 10 Aug 2001 07:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267053AbRHJLqr>; Fri, 10 Aug 2001 07:46:47 -0400
Received: from mx6.port.ru ([194.67.57.16]:40466 "EHLO mx6.port.ru")
	by vger.kernel.org with ESMTP id <S267043AbRHJLqi>;
	Fri, 10 Aug 2001 07:46:38 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: possible ip checksumming issues?
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 10.0.0.1 via proxy [195.34.30.63]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E15VAkM-000ClB-00@f4.mail.ru>
Date: Fri, 10 Aug 2001 15:46:34 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     I`ve got a following problem with kernels
 2.4.4-2.4.7 on two different hosts, two different
 modems (so it hardly can be an hardware issue):
 when i try to gather some files ( http://uwsg.iu.edu/hypermail/linux/kernel/0108.1/0367.html
 for example) receive stalls at some fixed offsets,
 which ones are strictly individual for each failing file.
 these errors are unrecoverable, i.e. i can`t by any
 means download such files.

 it seems to me that these errors are strictly data-
 dependent, so i made an assumption  about ip checksumming.

---


cheers,


   Samium Gromoff
