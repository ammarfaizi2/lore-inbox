Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbTDEHjp (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 02:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTDEHjp (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 02:39:45 -0500
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:61200 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261927AbTDEHjp (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 02:39:45 -0500
Message-ID: <3E8E8AA4.3070302@yahoo.com>
Date: Fri, 04 Apr 2003 23:49:56 -0800
From: Lars <lhofhansl@yahoo.com>
Organization: What? Organized??
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre7 and ac97_code.c compilation problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems prepatch 2.4.21-pre7 changes ac97_codec.c without making
matching changes in ac97_codec.h... Just a heads up.

The changes to ac97_codec.c are isolated enough so that I could easily
reverse that part of the patch to get it to work.

I'm not subscribed to this list, please CC me on any responses.

Thanks.

-- Lars

