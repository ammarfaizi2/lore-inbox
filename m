Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266395AbUAOAt5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 19:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266374AbUAOArb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 19:47:31 -0500
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:14930 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266348AbUAOAow convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 19:44:52 -0500
From: Murilo Pontes <murilo_pontes@yahoo.com.br>
To: linux-kernel@vger.kernel.org
Subject: BUG: loop device not work in 2.6.1-mm2 an 2.6.1-mm3
Date: Wed, 14 Jan 2004 21:45:10 +0000
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401142145.10905.murilo_pontes@yahoo.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


21:44:56 [root@murilo:~]#mount -V
mount: mount-2.12

umount: /tmp/ramdisk_mountdir: não montado
ioctl: LOOP_CLR_FD: No such device or address
mount: será usado o dispositivo de laço /dev/loop/0
ioctl: LOOP_SET_FD: Argumento inválido


