Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbUL0TSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbUL0TSE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 14:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbUL0TSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 14:18:04 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:38679 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261942AbUL0TSB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 14:18:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=iQX7H51vdyOJBD3dNg0YEo7jAlBhuwf7OYefmfPqNBuKcYGYgAHVJxoqv/an6TJsbMl3ORWVWmBCOqWBzG9+TPH5AJGcR/0xzbbaswouYSIWOd/+c9LpgC1LLyGcwiRdiy2MXuyzA6+BJBQAmjl5CuWOYwkP09LrhOf8crgD5DM=
Message-ID: <d5a95e6d04122711183596d0c8@mail.gmail.com>
Date: Mon, 27 Dec 2004 16:18:00 -0300
From: Diego <foxdemon@gmail.com>
Reply-To: Diego <foxdemon@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: About NFS4 in kernel 2.6.9
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 I have recompile fedora core 3 to kernel 2.6.9 and tried to user NFS,
I configure but when i have some problems:
 root@c-57-137-05 ~]# service nfs restart
Desligando o NFS mountd:                                   [FALHOU]
Desligando o servidor NFS:                                 [FALHOU]
Desligando o NFS quotas:                                   [FALHOU]
Desligando serviços NFS:                                   [  OK  ]
Iniciando os serviços NFS:                                 [  OK  ]
Iniciando as quatas do NFS:                                [  OK  ]
Iniciando servidor NFS:                                    [FALHOU]
Iniciando o NFS mountd:                                    [  OK  ]
Iniciando NFS4 idmapd: FATAL: Module sunrpc not found.
FATAL: Error running install command for sunrpc

I dont know what is the problem, whem i recompile the kernel, i
compile support to NFSv4. Somebody help me, please.
Thanks for your help.


Diego.
