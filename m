Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264480AbTCXWkK>; Mon, 24 Mar 2003 17:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264481AbTCXWkJ>; Mon, 24 Mar 2003 17:40:09 -0500
Received: from host-132.c8b96c.mrconcursos.com.br ([200.185.108.132]:47083
	"EHLO maisbrasil.com.br") by vger.kernel.org with ESMTP
	id <S264480AbTCXWkH>; Mon, 24 Mar 2003 17:40:07 -0500
Message-ID: <000701c2f257$d1831320$09dea7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "Kernel List" <linux-kernel@vger.kernel.org>
Subject: look data in stack area
Date: Mon, 24 Mar 2003 19:50:50 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
X-XTmail: http://www.verdesmares.com davi@verdesmares.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I´d like to do a module that can look the data of stack area , and if it
search a specific  code , it will do something.

i.e.

1º Process A is running
2º A module is looking data in stack area
3º A /bin/sh code was found
4º Module do something with this process.

My question is :  how can i look the data of stack area with a module ?
Can you give me some opinions , please ?

Thanks
Breno

