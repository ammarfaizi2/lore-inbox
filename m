Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264702AbSKVMzi>; Fri, 22 Nov 2002 07:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbSKVMzi>; Fri, 22 Nov 2002 07:55:38 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:2311 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id <S264702AbSKVMzh>;
	Fri, 22 Nov 2002 07:55:37 -0500
Message-ID: <3DDC6AD0.40906@iinet.net.au>
Date: Thu, 21 Nov 2002 16:10:40 +1100
From: Nero <neroz@iinet.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Qt 3.1 and xconfig
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you link against qt 3.1 (and this will be common soon, KDE 3.1 
requires it), you can't change any of the options. There is a warning 
when it is running:

QObject::connect: No such signal ConfigList::menuSelected(struct menu*)
QObject::connect:  (sender name:   'unnamed')
QObject::connect:  (receiver name: 'unnamed')
QObject::connect: No such signal ConfigList::menuSelected(struct menu*)
QObject::connect:  (sender name:   'unnamed')
QObject::connect:  (receiver name: 'unnamed')


