Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318231AbSGQHMM>; Wed, 17 Jul 2002 03:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318232AbSGQHML>; Wed, 17 Jul 2002 03:12:11 -0400
Received: from 205-158-62-95.outblaze.com ([205.158.62.95]:62343 "HELO
	ws3-5.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S318231AbSGQHMK>; Wed, 17 Jul 2002 03:12:10 -0400
Message-ID: <20020717071503.17397.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Balakrishnan Ananthanarayanan" <balakris_ananth@email.com>
To: linux-mips@oss.sgi.com, linux-kernel@vger.kernel.org,
       redhat-list@redhat.com
Date: Wed, 17 Jul 2002 02:15:03 -0500
Subject: 2.4.17 - compile error
X-Originating-Ip: 202.140.142.131
X-Originating-Server: ws3-5.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all, 

    I'm compiling 2.4.17 to work for mips. I get the following error: 

mips_ksyms.c:44: parse error before 'this_object_must_be_defined_as_export_objs_in_the_Makefile' 

mips_ksyms.c:44: warning: type defaults to `int' in declaration of `this_object_must_be_defined_as_export_objs_in_the_Makefile'

mips_ksyms.c:44: warning: data definition has no type or storage class

The same errors repeat themselves at certain line numbers till line 140. What shud I do? Please help. 

Thanks, 
Balakrishnan

-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Save up to $160 by signing up for NetZero Platinum Internet service.
http://www.netzero.net/?refcd=N2P0602NEP8

