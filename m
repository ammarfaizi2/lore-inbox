Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264331AbRFIPIT>; Sat, 9 Jun 2001 11:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264347AbRFIPIJ>; Sat, 9 Jun 2001 11:08:09 -0400
Received: from HSE-MTL-ppp72639.qc.sympatico.ca ([64.229.201.194]:23680 "HELO
	oscar.casa.dyndns.org") by vger.kernel.org with SMTP
	id <S264331AbRFIPHy>; Sat, 9 Jun 2001 11:07:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: missing symbol do_softirq in net moduels for pre-2
Date: Sat, 9 Jun 2001 11:07:52 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01060911075200.00993@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Built -pre2 and noticed most of the modules in net/* are getting
a missing symbol for do_softirq.  

Have I messed up, or is there a real error?

Ed Tomlinson <tomlins@cam.org>
