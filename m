Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266808AbRGFVPK>; Fri, 6 Jul 2001 17:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266852AbRGFVPA>; Fri, 6 Jul 2001 17:15:00 -0400
Received: from kitkat.hotpop.com ([204.57.55.30]:15372 "HELO kitkat.hotpop.com")
	by vger.kernel.org with SMTP id <S266808AbRGFVOo>;
	Fri, 6 Jul 2001 17:14:44 -0400
Message-ID: <004701c10660$f64923a0$43020180@linfpaulo>
From: "Paulo" <pmateiro@hotpop.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <3B4624C9.18290280@centtech.com>
Subject: NCR 35XXXX MCA bus and SMP
Date: Fri, 6 Jul 2001 18:16:43 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 1
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Friends, my name is Paulo.
And i have a NCR 3525 with MCA bus and 8 processors and 512MB RAM
, i tried Suse 6.4 and Red Hat 7.1 , but nome detected
my MCA bus , the 8 processors and more than 64MB ... i tried kernel
parameter
mem=512m , but no results... only 64MB .... i recompiled the kernel (2.4.2)
with MCA=y and SMP =y ... and no results...
somebody can help me ?

Paulo Mateiro.


