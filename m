Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262410AbSJ0O4h>; Sun, 27 Oct 2002 09:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262415AbSJ0O4g>; Sun, 27 Oct 2002 09:56:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45838 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262410AbSJ0O4g>;
	Sun, 27 Oct 2002 09:56:36 -0500
Message-ID: <3DBC0007.8020005@pobox.com>
Date: Sun, 27 Oct 2002 10:02:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Haumer <andreas@xss.co.at>
CC: linux-kernel@vger.kernel.org, willy@w.ods.org
Subject: Re: rootfs exposure in /proc/mounts
References: <Pine.GSO.4.21.0210261458460.29768-100000@steklov.math.psu.edu> <3DBAE931.7000409@domdv.de> <3DBAEC79.5050605@pobox.com> <3DBBBE1B.5050809@xss.co.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

symlinks directly to /proc/mounts is fine with me -- just don't expect 
any sympathy when userspace tools don't handle things like $subject.  :) 
 The answer will be "fix the userspace tools" not "add special case code 
to the kernel" :)

    Jeff




