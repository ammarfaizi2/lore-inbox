Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280593AbRKSSnh>; Mon, 19 Nov 2001 13:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280594AbRKSSnW>; Mon, 19 Nov 2001 13:43:22 -0500
Received: from freeside.toyota.com ([63.87.74.7]:21767 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S280591AbRKSSmp>; Mon, 19 Nov 2001 13:42:45 -0500
Message-ID: <3BF9529C.38228533@lexus.com>
Date: Mon, 19 Nov 2001 10:42:36 -0800
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.15-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
CC: James A Sutherland <jas88@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: x bit for dirs: misfeature?
In-Reply-To: <01111916225301.00817@nemo> <E165pWu-0000Pi-00@mauve.csi.cam.ac.uk> <01111916583804.00817@nemo>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vda wrote:

> I know. I'd like to hear anybody who have a directory with r!=x
> on purpose (and quite curious on that purpose). UNIX gugus, anybody?

Absolutely -

It is quite common to have dirs with perms 711 -

This allows arbitrary users to copy specific files
from such a directory, but does not allow them to
cd into that directory or to browse it.

Losing that distinction would be crippling.

cu

jjs

